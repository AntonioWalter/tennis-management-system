import javax.swing.*;
import javax.swing.table.DefaultTableCellRenderer;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

// Classe per la GUI
public class MainGUI extends JFrame {
    private JTextArea queryResult;      // Piccolo spazio nel quale è mostrato lo stato finale di esecuzione della query
    private JPanel inputPanel;      // Pannello di inserimento dei parametri di input
    private JTextField[] inputFields;        //Campi di inserimento dei parametri
    private JComboBox<String> querySelector;        //Selettore delle query
    private JLabel[] inputLabels;     // Label per la descrizione dei parametri di input

    public MainGUI() {
        setTitle("Gestione Database");
        setSize(800, 600);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new BorderLayout());

        // Pannello superiore per la selezione delle query
        JPanel topPanel = new JPanel(new GridLayout(2, 1));
        querySelector = new JComboBox<>(new String[]{
                "1. Inserisci Allenatore", "2. Inserisci Rappresentazione",
                "3. Visualizza Sponsor di Giocatore", "4. Giocatori di un Allenatore",
                "5. Sponsor di Giocatori Allenati", "6. Crea Torneo",
                "7. Guadagno Annuale Giocatore", "8. Vincitore Torneo",
                "9. Punti Ultimo Anno", "10. Aggiorna Punti Giocatori",
                "11. Aggiorna Primo Classificato Enti", "12. Ranking ATP",
                "13. Ranking WTA", "14. Ranking ITF", "15. Tornei di un giocatore"
        });
        topPanel.add(querySelector);
        JButton executeButton = new JButton("Esegui Query");    // Pulsante per l'esecuzione delle query
        topPanel.add(executeButton);
        add(topPanel, BorderLayout.NORTH);

        // Pannello centrale per l'input dell'utente
        inputPanel = new JPanel();
        add(inputPanel, BorderLayout.CENTER);

        // Area di output
        queryResult = new JTextArea();
        add(new JScrollPane(queryResult), BorderLayout.SOUTH);

        // Azione del pulsante di esecuzione delle query
        executeButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                executeSelectedQuery();
            }
        });

        // Gestione selezione delle query
        querySelector.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                updateInputFields();
            }
        });

        updateInputFields(); // Inizializza campi input
    }

    // Metodo per l' aggiornamento dei campi e delle label di input
    private void updateInputFields() {
        int selectedIndex = querySelector.getSelectedIndex() + 1;
        List<String> params = getParameterNames(selectedIndex);

        inputPanel.removeAll(); // Pulisci pannello input
        inputFields = new JTextField[params.size()];
        inputLabels = new JLabel[params.size()];
        inputPanel.setLayout(new GridLayout(params.size(), 2));

        for (int i = 0; i < params.size(); i++) {
            inputLabels[i] = new JLabel(params.get(i) + ":");
            inputFields[i] = new JTextField();
            inputPanel.add(inputLabels[i]);
            inputPanel.add(inputFields[i]);
        }

        inputPanel.revalidate();
        inputPanel.repaint();
    }

    // Metodo che indica quali parametri prendere in input in base alla query selezionata
    private List<String> getParameterNames(int queryNumber) {
        switch (queryNumber) {
            case 1: return Arrays.asList("Nome", "Cognome", "Ex_giocatore");
            case 2: return Arrays.asList("Giocatore", "Sponsor", "Durata_contratto", "Compenso");
            case 3: return Arrays.asList("ID Giocatore");
            case 4: return Arrays.asList("ID Allenatore");
            case 5: return Arrays.asList("ID Allenatore");
            case 6: return Arrays.asList("Nome", "Tipologia", "Punti", "Anno", "Premio_in_denaro", "ID Ente Organizzatore");
            case 7: return Arrays.asList();
            case 8: return Arrays.asList("Nome Torneo", "Anno Torneo");
            case 9: return Arrays.asList("ID Giocatore");
            case 10: return Arrays.asList();
            case 11: return Arrays.asList();
            case 12: return Arrays.asList();
            case 13: return Arrays.asList();
            case 14: return Arrays.asList();
            case 15: return Arrays.asList("ID Giocatore");
            default: return Arrays.asList();
        }
    }

    // Metodo richiamato dal pulsante di esecuzione che esegue la query in base a quella selezionata nel pannello di selezione
    private void executeSelectedQuery() {
        int selectedIndex = querySelector.getSelectedIndex() + 1;
        Object[] params = new Object[inputFields.length];
        for (int i = 0; i < inputFields.length; i++) {
            params[i] = inputFields[i].getText().trim();
        }

        try (Connection conn = DatabaseConnection.getConnection()) {
            Object result;

            switch (selectedIndex) {
                case 1:
                    result = QueryManager.inserisciAllenatore(conn, params);
                    break;
                case 2:
                    result = QueryManager.inserisciRappresentazione(conn, params);
                    break;
                case 3:
                    result = QueryManager.visualizzaSponsorDiGiocatore(conn, params);
                    break;
                case 4:
                    result = QueryManager.giocatoriDiUnAllenatore(conn, params);
                    break;
                case 5:
                    result = QueryManager.sponsorDiGiocatoriAllenati(conn, params);
                    break;
                case 6:
                    result = QueryManager.creaTorneo(conn, params);
                    break;
                case 7:
                    result = QueryManager.guadagnoAnnualeGiocatore(conn, params);
                    break;
                case 8:
                    result = QueryManager.vincitoreTorneo(conn, params);
                    break;
                case 9:
                    result = QueryManager.puntiUltimoAnno(conn, params);
                    break;
                case 10:
                    result = QueryManager.aggiornaPuntiGiocatori(conn);
                    break;
                case 11:
                    result = QueryManager.aggiornaPrimoClassificatoEnti(conn);
                    break;
                case 12:
                    result = QueryManager.stampaRankingATP(conn);
                    break;
                case 13:
                    result = QueryManager.stampaRankingWTA(conn);
                    break;
                case 14:
                    result = QueryManager.stampaRankingITF(conn);
                    break;
                case 15:
                    result = QueryManager.stampaTorneiGiocatore(conn, params);
                    break;
                default:
                    throw new IllegalArgumentException("Query non valida: " + selectedIndex);
            }

            if (result instanceof ResultSet) {      // Se l'output della query è un resultset allora viene chiamato il metodo di display altrimenti aggiornato il campo di informazioni sull esecuzione
                displayResult((ResultSet) result);
            } else if (result instanceof Integer) {
                int rowsAffected = (Integer) result;
                String message = (rowsAffected > 0) ?
                        rowsAffected + " righe modificate con successo." :
                        "Nessuna riga modificata.";
                queryResult.setText(message);
                JOptionPane.showMessageDialog(this, message, "Risultato Query", JOptionPane.INFORMATION_MESSAGE);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            String errorMessage = "Errore nell'esecuzione della query: " + e.getMessage();
            queryResult.setText(errorMessage);
            JOptionPane.showMessageDialog(this, errorMessage, "Errore", JOptionPane.ERROR_MESSAGE);
        }
    }

    //Metodo per la stampa grafica delle relazioni ottenute dalle query di interrogazione
    private void displayResult(ResultSet rs) {
        try {
            if (rs == null) {
                queryResult.setText("Errore nell'esecuzione della query");
                return;
            }

            DefaultTableModel model = new DefaultTableModel();
            JTable table = new JTable(model);
            queryResult.setText("");
            int columnCount = rs.getMetaData().getColumnCount();
            for (int i = 1; i <= columnCount; i++) {
                model.addColumn(rs.getMetaData().getColumnName(i));
            }
            while (rs.next()) {
                Object[] row = new Object[columnCount];
                for (int i = 0; i < columnCount; i++) {
                    row[i] = rs.getObject(i + 1);
                }
                model.addRow(row);
            }

            table.setRowHeight(30);

            table.setDefaultRenderer(Object.class, new DefaultTableCellRenderer() {
                @Override
                public Component getTableCellRendererComponent(JTable table, Object value, boolean isSelected, boolean hasFocus, int row, int column) {
                    Component c = super.getTableCellRendererComponent(table, value, isSelected, hasFocus, row, column);
                    setHorizontalAlignment(SwingConstants.CENTER);
                    setBorder(BorderFactory.createLineBorder(Color.BLACK, 1));
                    return c;
                }
            });

            for (int column = 0; column < columnCount; column++) {
                int maxWidth = 0;


                String headerText = table.getColumnModel().getColumn(column).getHeaderValue().toString();
                FontMetrics fm = table.getFontMetrics(table.getFont());
                int headerWidth = fm.stringWidth(headerText);
                maxWidth = Math.max(maxWidth, headerWidth);


                for (int row = 0; row < table.getRowCount(); row++) {
                    Component cell = table.prepareRenderer(table.getCellRenderer(row, column), row, column);
                    maxWidth = Math.max(maxWidth, cell.getPreferredSize().width);
                }

                table.getColumnModel().getColumn(column).setPreferredWidth(maxWidth + 20);
            }

            JOptionPane.showMessageDialog(this, new JScrollPane(table), "Risultati", JOptionPane.INFORMATION_MESSAGE);

        } catch (SQLException e) {
            e.printStackTrace();
            queryResult.setText("Errore nell'esecuzione della query");
        }
    }

    // Main
    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> new MainGUI().setVisible(true));
    }
}