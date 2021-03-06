package UI;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;

import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.Clip;
import javax.sound.sampled.DataLine;
import javax.sound.sampled.LineUnavailableException;
import javax.sound.sampled.Mixer;
import javax.sound.sampled.UnsupportedAudioFileException;
import javax.swing.JFileChooser;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import javax.swing.table.DefaultTableModel;

import DAL.DataProvider;
import DTO.Broadcast;
import DTO.Request;
import DTO.Song;
import DTO.User;

public class Main extends javax.swing.JFrame implements ActionListener {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public Main() {
		initComponents();
		showSongs();
		showRequests();
		showFavoriteSongs();
		showUnresolvedSongs();
		showRequestExceptions();
		showBroadcasts();
	}

	public void showBroadcasts() {
		ArrayList<Broadcast> broadcastList = new DataProvider().broadcastList();
		DefaultTableModel model = (DefaultTableModel) jTableBroadcasts.getModel();
		Object[] row = new Object[4];
		model.setNumRows(0);
		for (int i = 0; i < broadcastList.size(); ++i) {
			row[0] = i + 1;
			row[1] = "BC" + broadcastList.get(i).getId();
			row[2] = broadcastList.get(i).getName();
			row[3] = broadcastList.get(i).getCreatedAt();
			model.addRow(row);
		}
		jTableBroadcasts.changeSelection(0, 0, false, false);
		showBroadcastRequests(broadcastList.get(0).getId());
	}
	
	public void addToBroadcast(Broadcast broadcast) {
		DefaultTableModel model = (DefaultTableModel) jTableBroadcasts.getModel();
		Object[] row = new Object[4];
		row[0] = jTableBroadcasts.getRowCount() + 1;
		row[1] = "BC" + broadcast.getId();
		row[2] = broadcast.getName();
		row[3] = broadcast.getCreatedAt();
		model.addRow(row);
	}

	public void showRequestExceptions() {
		ArrayList<Request> requestList = new DataProvider().requestExceptionList();
		DefaultTableModel model = (DefaultTableModel) jTableRequestExceptions.getModel();
		Object[] row = new Object[3];
		model.setNumRows(0);

		for (int i = 0; i < requestList.size(); i++) {
			row[0] = requestList.get(i).getUserName();
			row[1] = "SO" + requestList.get(i).getSongId();
			row[2] = requestList.get(i).getException();
			model.addRow(row);
		}
	}
	public void showBroadcastRequests(String broadcastId) {
		ArrayList<Request> broadcastRequest = new DataProvider().broadcastRequestList(broadcastId);
		DefaultTableModel model = (DefaultTableModel) jTableBroadcastRequest.getModel();
		model.setNumRows(0);
		Object[] row = new Object[4];

		for (int i = 0; i < broadcastRequest.size(); i++) {
			row[1] = broadcastRequest.get(i).getUserName();
			row[2] = broadcastRequest.get(i).getSongName();
			row[3] = broadcastRequest.get(i).getSingerName();
			row[0] = broadcastRequest.get(i).getOrderNumber();
			model.addRow(row);
		}
	}

	public void showSongs() {
		ArrayList<Song> songList = new DataProvider().songList();
		DefaultTableModel model = (DefaultTableModel) jTableSong.getModel();
		model.setNumRows(0);
		Object[] row = new Object[4];

		for (int i = 0; i < songList.size(); i++) {
			row[0] = "SO" + songList.get(i).getId();
			row[1] = songList.get(i).getName();
			row[2] = songList.get(i).getComposer();
			row[3] = songList.get(i).getSinger();
			model.addRow(row);
		}
	}

	public void showRequests() {
		ArrayList<Request> requestList = new DataProvider().requestList();
		DefaultTableModel model = (DefaultTableModel) jTableRequest.getModel();
		Object[] row = new Object[7];
		model.setNumRows(0);
		for (int i = 0; i < requestList.size(); i++) {
			row[1] = requestList.get(i).getUserName();
			row[2] = requestList.get(i).getCreatedAt();
			row[3] = requestList.get(i).getSongName();
			row[4] = requestList.get(i).getSingerName();
			row[5] = requestList.get(i).getComposerName();
			row[6] = requestList.get(i).getResolved() == true ? "Đã phát" : "Chưa phát";
			row[0] = "RE" + requestList.get(i).getId();
			model.addRow(row);
		}
	}

	public void showFavoriteSongs() {
		ArrayList<Song> favoriteSongList = new DataProvider().favoriteSongList();
		DefaultTableModel model = (DefaultTableModel) jTableFavoriteSong.getModel();
		Object[] row = new Object[4];
		model.setNumRows(0);

		for (int i = 0; i < favoriteSongList.size(); i++) {
			row[0] = i + 1;
			row[1] = "SO" + favoriteSongList.get(i).getId();
			row[2] = favoriteSongList.get(i).getName();
			row[3] = favoriteSongList.get(i).getRequestCount();
			model.addRow(row);
		}
	}

	public void showUnresolvedSongs() {
		ArrayList<Song> unresolvedSongList = new DataProvider().unresolvedSongList();
		DefaultTableModel model = (DefaultTableModel) jTableUnresolvedSong.getModel();
		Object[] row = new Object[4];
		model.setNumRows(0);
		for (int i = 0; i < unresolvedSongList.size(); i++) {
			row[0] = i + 1;
			row[1] = "SO" + unresolvedSongList.get(i).getId();
			row[2] = unresolvedSongList.get(i).getName();
			row[3] = unresolvedSongList.get(i).getRequestCount();
			model.addRow(row);
		}
	}

	@SuppressWarnings("deprecation")
	private void initComponents() {

		jTabbedPane6 = new javax.swing.JTabbedPane();
		jPanel1 = new javax.swing.JPanel();
		jPanel5 = new javax.swing.JPanel();
		jPanel6 = new javax.swing.JPanel();
		jLabel1 = new javax.swing.JLabel();
		jScrollPane1 = new javax.swing.JScrollPane();
		jTableBroadcasts = new javax.swing.JTable();
		jTableBroadcastRequest = new javax.swing.JTable();
		jPanel7 = new javax.swing.JPanel();
		jButtonPlayBroadcast = new javax.swing.JButton("jButtonPlayBroadcast");
		jPanel2 = new javax.swing.JPanel();
		jPanel8 = new javax.swing.JPanel();
		jPanel9 = new javax.swing.JPanel();
		jScrollPane2 = new javax.swing.JScrollPane();
		jScrollPane5 = new javax.swing.JScrollPane();
		jTableSong = new javax.swing.JTable();
		jLabel2 = new javax.swing.JLabel();
		jPanel10 = new javax.swing.JPanel();
		jLabel3 = new javax.swing.JLabel();
		jLabel13 = new javax.swing.JLabel();
		jPanel11 = new javax.swing.JPanel();
		jLabel8 = new javax.swing.JLabel();
		jButtonDeselected = new javax.swing.JButton("jButtonDeselected");
		jTextFieldSongName = new javax.swing.JTextField();
		jLabel9 = new javax.swing.JLabel();
		jTextFieldComposerName = new javax.swing.JTextField();
		jLabel10 = new javax.swing.JLabel();
		jTextFieldSingerName = new javax.swing.JTextField();
		jLabel11 = new javax.swing.JLabel();
		jTextFieldLink = new javax.swing.JTextField();
		jButtonFileChoosing = new javax.swing.JButton("jButtonFileChoosing");
		jButtonAddSong = new javax.swing.JButton("jButtonAddSong");
		jPanel3 = new javax.swing.JPanel();
		jPanel35 = new javax.swing.JPanel();
		jPanel36 = new javax.swing.JPanel();
		jScrollPane13 = new javax.swing.JScrollPane();
		jTableRequest = new javax.swing.JTable();
		jButtonDeleteRequest = new javax.swing.JButton("jButtonDeleteRequest");
		jLabel15 = new javax.swing.JLabel();
		jPanel37 = new javax.swing.JPanel();
		jLabel16 = new javax.swing.JLabel();
		jPanel40 = new javax.swing.JPanel();
		jLabel19 = new javax.swing.JLabel();
		jTextFieldRequester = new javax.swing.JTextField();
		jLabel4 = new javax.swing.JLabel();
		jTextFieldSongId = new javax.swing.JTextField();
		jLabel6 = new javax.swing.JLabel();
		jTextFieldRequesterPhone = new javax.swing.JTextField();
		jLabel7 = new javax.swing.JLabel();
		jScrollPane3 = new javax.swing.JScrollPane();
		jTextAreaRequesterMessage = new javax.swing.JTextArea();
		jButtonAddRequest = new javax.swing.JButton("jButtonAddRequest");
		jPanel4 = new javax.swing.JPanel();
		jPanel14 = new javax.swing.JPanel();
		jPanel12 = new javax.swing.JPanel();
		jScrollPane14 = new javax.swing.JScrollPane();
		jTableUnresolvedSong = new javax.swing.JTable();
		jPanel15 = new javax.swing.JPanel();
		jLabel5 = new javax.swing.JLabel();
		jScrollPane15 = new javax.swing.JScrollPane();
		jTableFavoriteSong = new javax.swing.JTable();
		jPanel34 = new javax.swing.JPanel();
		jLabel17 = new javax.swing.JLabel();
		jScrollPane16 = new javax.swing.JScrollPane();
		jTableRequestExceptions = new javax.swing.JTable();
		jPanel38 = new javax.swing.JPanel();
		jLabel18 = new javax.swing.JLabel();
		jButtonBroadCast = new javax.swing.JButton("jButtonBroadCast");
		jMenuBar1 = new javax.swing.JMenuBar();
		jMenu1 = new javax.swing.JMenu();
		jMenuItem1 = new javax.swing.JMenuItem();
		jMenuItem2 = new javax.swing.JMenuItem();
		jMenu2 = new javax.swing.JMenu();
		jMenuItem3 = new javax.swing.JMenuItem();
		jMenu4 = new javax.swing.JMenu();
		jMenuItem4 = new javax.swing.JMenuItem();
		jMenu3 = new javax.swing.JMenu();
		jMenuItem5 = new javax.swing.JMenuItem();
		jMenuItem6 = new javax.swing.JMenuItem();

		selectedSongId = "";

		setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
		setResizable(false);

		jTabbedPane6.setAutoscrolls(true);
		jTabbedPane6.setFocusable(false);
		jTabbedPane6.setFont(new java.awt.Font("Times New Roman", 0, 18)); 
		jTabbedPane6.setPreferredSize(new java.awt.Dimension(1156, 601));

		jPanel5.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));

		jLabel1.setFont(new java.awt.Font("Times New Roman", 0, 24)); 
		jLabel1.setText("DANH SÁCH PHÁT");

		javax.swing.GroupLayout jPanel6Layout = new javax.swing.GroupLayout(jPanel6);
		jPanel6.setLayout(jPanel6Layout);
		jPanel6Layout.setHorizontalGroup(jPanel6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel6Layout.createSequentialGroup().addGap(277, 277, 277).addComponent(jLabel1)
						.addContainerGap(277, Short.MAX_VALUE)));
		jPanel6Layout.setVerticalGroup(jPanel6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel6Layout.createSequentialGroup()
						.addContainerGap(21, Short.MAX_VALUE).addComponent(jLabel1).addContainerGap()));

		jTableBroadcasts.setModel(new javax.swing.table.DefaultTableModel(null,
				new String[] { "Số thứ tự ", "Mã phát sóng", "Tên", "Ngày phát" }));
		jScrollPane1.setViewportView(jTableBroadcasts);

		jTableBroadcasts.getSelectionModel().addListSelectionListener(new ListSelectionListener() {
			public void valueChanged(ListSelectionEvent event) {
				String broadcastId = (String) jTableBroadcasts.getValueAt(jTableBroadcasts.getSelectedRow(), 1);
				broadcastId = broadcastId.substring(2);
				showBroadcastRequests(broadcastId);
			}
		});

		jButtonPlayBroadcast.setText("PLAY");
		jButtonPlayBroadcast.addActionListener(this);

		javax.swing.GroupLayout jPanel7Layout = new javax.swing.GroupLayout(jPanel7);
		jPanel7.setLayout(jPanel7Layout);
		jPanel7Layout.setHorizontalGroup(jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel7Layout.createSequentialGroup().addContainerGap()
						.addComponent(jButtonPlayBroadcast, javax.swing.GroupLayout.PREFERRED_SIZE, 76,
								javax.swing.GroupLayout.PREFERRED_SIZE)
						.addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)));
		jPanel7Layout.setVerticalGroup(jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE).addComponent(
						jButtonPlayBroadcast, javax.swing.GroupLayout.DEFAULT_SIZE, 56, Short.MAX_VALUE)));

		jTableBroadcastRequest.setModel(new javax.swing.table.DefaultTableModel(null,
				new String[] { "Thứ tự phát", "Người yêu cầu", "Tên bài hát", "Ca sĩ" }));
		jScrollPane5.setViewportView(jTableBroadcastRequest);

		jLabel13.setFont(new java.awt.Font("Times New Roman", 0, 24)); 
		jLabel13.setText("Thông tin thêm");

		javax.swing.GroupLayout jPanel12Layout = new javax.swing.GroupLayout(jPanel12);
		jPanel12.setLayout(jPanel12Layout);
		jPanel12Layout.setHorizontalGroup(jPanel12Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel12Layout.createSequentialGroup()
						.addContainerGap(106, Short.MAX_VALUE).addComponent(jLabel13).addGap(96, 96, 96)));
		jPanel12Layout.setVerticalGroup(jPanel12Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(javax.swing.GroupLayout.Alignment.TRAILING,
						jPanel12Layout.createSequentialGroup()
								.addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
								.addComponent(jLabel13).addContainerGap()));

		javax.swing.GroupLayout jPanel5Layout = new javax.swing.GroupLayout(jPanel5);
		jPanel5.setLayout(jPanel5Layout);
		jPanel5Layout.setHorizontalGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel5Layout.createSequentialGroup().addContainerGap().addGroup(jPanel5Layout
						.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
						.addComponent(jPanel7, javax.swing.GroupLayout.DEFAULT_SIZE,
								javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
						.addGroup(jPanel5Layout.createSequentialGroup()
								.addGroup(jPanel5Layout
										.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING, false)
										.addComponent(jPanel6, javax.swing.GroupLayout.Alignment.LEADING,
												javax.swing.GroupLayout.DEFAULT_SIZE,
												javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
										.addComponent(jScrollPane1, javax.swing.GroupLayout.Alignment.LEADING))
								.addGap(18, 18, 18)
								.addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
										.addComponent(jScrollPane5, javax.swing.GroupLayout.PREFERRED_SIZE, 0,
												Short.MAX_VALUE)
										.addComponent(jPanel12, javax.swing.GroupLayout.DEFAULT_SIZE,
												javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))))
						.addContainerGap()));
		jPanel5Layout.setVerticalGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel5Layout.createSequentialGroup()
						.addContainerGap()
						.addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
								.addComponent(jPanel6, javax.swing.GroupLayout.DEFAULT_SIZE,
										javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
								.addComponent(jPanel12, javax.swing.GroupLayout.DEFAULT_SIZE,
										javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
						.addGap(24, 24, 24)
						.addGroup(
								jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
										.addComponent(jScrollPane5, javax.swing.GroupLayout.DEFAULT_SIZE, 453,
												Short.MAX_VALUE)
										.addComponent(jScrollPane1))
						.addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
						.addComponent(jPanel7, javax.swing.GroupLayout.PREFERRED_SIZE,
								javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
						.addContainerGap()));

		javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
		jPanel1.setLayout(jPanel1Layout);
		jPanel1Layout.setHorizontalGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel1Layout.createSequentialGroup().addContainerGap().addComponent(jPanel5,
						javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
						.addContainerGap()));
		jPanel1Layout.setVerticalGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel1Layout.createSequentialGroup().addContainerGap().addComponent(jPanel5,
						javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
						.addContainerGap()));

		jTabbedPane6.addTab("Phát nhạc", jPanel1);

		jPanel8.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));
		jPanel8.setPreferredSize(new java.awt.Dimension(1127, 601));

		jPanel9.setPreferredSize(new java.awt.Dimension(772, 572));

		jTableSong.setModel(new javax.swing.table.DefaultTableModel(null,
				new String[] { "Mã bài ", "Tên bài hát", "Tên nhạc sĩ", "Tên ca sĩ" }));
		jTableSong.setAutoscrolls(false);
		jScrollPane2.setViewportView(jTableSong);

		jTableSong.getSelectionModel().addListSelectionListener(new ListSelectionListener() {
			public void valueChanged(ListSelectionEvent event) {
				String songId = (String) jTableSong.getValueAt(jTableSong.getSelectedRow(), 0);
				songId = songId.substring(2);
				selectSong(songId);
			}
		});

		jButtonDeselected.setText("Bỏ chọn");
		jButtonDeselected.addActionListener(this);
		jLabel2.setFont(new java.awt.Font("Times New Roman", 0, 24)); 
		jLabel2.setText("DANH SÁCH BÀI HÁT");

		javax.swing.GroupLayout jPanel9Layout = new javax.swing.GroupLayout(jPanel9);
		jPanel9.setLayout(jPanel9Layout);
		jPanel9Layout.setHorizontalGroup(jPanel9Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel9Layout.createSequentialGroup().addContainerGap()
						.addGroup(jPanel9Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
								.addGroup(jPanel9Layout.createSequentialGroup()
										.addComponent(jScrollPane2, javax.swing.GroupLayout.DEFAULT_SIZE, 748,
												Short.MAX_VALUE)
										.addContainerGap())
								.addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel9Layout
										.createSequentialGroup().addGap(0, 0, Short.MAX_VALUE)
										.addGroup(jPanel9Layout
												.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
												.addGroup(javax.swing.GroupLayout.Alignment.TRAILING,
														jPanel9Layout.createSequentialGroup().addComponent(jLabel2)
																.addGap(262, 262, 262))
												.addGroup(javax.swing.GroupLayout.Alignment.TRAILING,
														jPanel9Layout.createSequentialGroup()
																.addComponent(jButtonDeselected,
																		javax.swing.GroupLayout.PREFERRED_SIZE, 113,
																		javax.swing.GroupLayout.PREFERRED_SIZE)

																.addContainerGap()))))));
		jPanel9Layout.setVerticalGroup(jPanel9Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel9Layout.createSequentialGroup().addContainerGap().addComponent(jLabel2)
						.addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED).addComponent(jScrollPane2)
						.addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
						.addComponent(jButtonDeselected, javax.swing.GroupLayout.PREFERRED_SIZE, 37,
								javax.swing.GroupLayout.PREFERRED_SIZE)
						.addContainerGap()));

		jPanel10.setPreferredSize(new java.awt.Dimension(315, 575));

		jLabel3.setFont(new java.awt.Font("Times New Roman", 0, 24)); 
		jLabel3.setText("THÊM BÀI HÁT");

		jPanel11.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));
		jPanel11.setPreferredSize(new java.awt.Dimension(192, 451));

		jLabel8.setFont(new java.awt.Font("Times New Roman", 0, 14)); 
		jLabel8.setText("Tên bài hát*");

		jTextFieldSongName.setFont(new java.awt.Font("Times New Roman", 0, 14)); 

		jLabel9.setFont(new java.awt.Font("Times New Roman", 0, 14)); 
		jLabel9.setText("Tên nhạc sĩ*");

		jTextFieldComposerName.setFont(new java.awt.Font("Times New Roman", 0, 14)); 

		jLabel10.setFont(new java.awt.Font("Times New Roman", 0, 14)); 
		jLabel10.setText("Tên ca sĩ*");

		jLabel11.setFont(new java.awt.Font("Times New Roman", 0, 14)); 
		jLabel11.setText("Đường dẫn");

		jTextFieldLink.setFont(new java.awt.Font("Tahoma", 0, 14)); 

		jButtonFileChoosing.setText("...");
		jButtonFileChoosing.addActionListener(this);

		javax.swing.GroupLayout jPanel11Layout = new javax.swing.GroupLayout(jPanel11);
		jPanel11.setLayout(jPanel11Layout);
		jPanel11Layout.setHorizontalGroup(jPanel11Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel11Layout.createSequentialGroup()
						.addContainerGap()
						.addGroup(jPanel11Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
								.addGroup(jPanel11Layout.createSequentialGroup().addGroup(jPanel11Layout
										.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
										.addComponent(jLabel8, javax.swing.GroupLayout.DEFAULT_SIZE,
												javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
										.addComponent(jLabel9, javax.swing.GroupLayout.DEFAULT_SIZE,
												javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
										.addComponent(jLabel10, javax.swing.GroupLayout.DEFAULT_SIZE,
												javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
										.addComponent(jLabel11, javax.swing.GroupLayout.DEFAULT_SIZE,
												javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
										.addGap(18, 18, 18)
										.addGroup(jPanel11Layout
												.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
												.addComponent(jTextFieldSingerName,
														javax.swing.GroupLayout.DEFAULT_SIZE, 170, Short.MAX_VALUE)
												.addComponent(jTextFieldComposerName).addComponent(jTextFieldSongName)))
								.addGroup(jPanel11Layout.createSequentialGroup().addGap(0, 5, Short.MAX_VALUE)
										.addGroup(jPanel11Layout
												.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
												.addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel11Layout
														.createSequentialGroup()
														.addComponent(jTextFieldLink,
																javax.swing.GroupLayout.PREFERRED_SIZE, 223,
																javax.swing.GroupLayout.PREFERRED_SIZE)
														.addPreferredGap(
																javax.swing.LayoutStyle.ComponentPlacement.RELATED)
														.addComponent(jButtonFileChoosing,
																javax.swing.GroupLayout.PREFERRED_SIZE, 26,
																javax.swing.GroupLayout.PREFERRED_SIZE))
												.addGroup(javax.swing.GroupLayout.Alignment.TRAILING,
														jPanel11Layout.createSequentialGroup()
																.addGap(221, 221, 221)))))
						.addContainerGap()));
		jPanel11Layout.setVerticalGroup(jPanel11Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel11Layout.createSequentialGroup().addGap(28, 28, 28)
						.addGroup(jPanel11Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE))
						.addGap(18, 18, 18)
						.addGroup(jPanel11Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
								.addComponent(jLabel8)
								.addComponent(jTextFieldSongName, javax.swing.GroupLayout.PREFERRED_SIZE,
										javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
						.addGap(18, 18, 18)
						.addGroup(jPanel11Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
								.addComponent(jLabel9)
								.addComponent(jTextFieldComposerName, javax.swing.GroupLayout.PREFERRED_SIZE,
										javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
						.addGap(18, 18, 18)
						.addGroup(jPanel11Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
								.addComponent(jLabel10).addComponent(jTextFieldSingerName,
										javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE,
										javax.swing.GroupLayout.PREFERRED_SIZE))
						.addGap(18, 18, 18).addComponent(jLabel11)
						.addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
						.addGroup(jPanel11Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
								.addComponent(jTextFieldLink, javax.swing.GroupLayout.PREFERRED_SIZE,
										javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
								.addComponent(jButtonFileChoosing))
						.addGap(18, 18, 18)
						.addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
						.addContainerGap()));

		jButtonAddSong.setText("Thêm");
		jButtonAddSong.addActionListener(this);
		jButtonAddSong.setMaximumSize(new java.awt.Dimension(55, 25));
		jButtonAddSong.setMinimumSize(new java.awt.Dimension(55, 25));
		jButtonAddSong.setPreferredSize(new java.awt.Dimension(55, 25));

		javax.swing.GroupLayout jPanel10Layout = new javax.swing.GroupLayout(jPanel10);
		jPanel10.setLayout(jPanel10Layout);
		jPanel10Layout.setHorizontalGroup(jPanel10Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel10Layout.createSequentialGroup().addContainerGap().addGroup(jPanel10Layout
						.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
						.addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel10Layout.createSequentialGroup()
								.addGap(0, 0, Short.MAX_VALUE)
								.addGroup(jPanel10Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
										.addGroup(javax.swing.GroupLayout.Alignment.TRAILING,
												jPanel10Layout.createSequentialGroup().addComponent(jLabel3).addGap(72,
														72, 72))
										.addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel10Layout
												.createSequentialGroup()
												.addComponent(jButtonAddSong, javax.swing.GroupLayout.PREFERRED_SIZE,
														113, javax.swing.GroupLayout.PREFERRED_SIZE)
												.addContainerGap())))
						.addGroup(javax.swing.GroupLayout.Alignment.TRAILING,
								jPanel10Layout
										.createSequentialGroup().addComponent(jPanel11,
												javax.swing.GroupLayout.DEFAULT_SIZE, 300, Short.MAX_VALUE)
										.addContainerGap()))));
		jPanel10Layout.setVerticalGroup(jPanel10Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel10Layout.createSequentialGroup().addContainerGap().addComponent(jLabel3)
						.addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
						.addComponent(jPanel11, javax.swing.GroupLayout.DEFAULT_SIZE, 469, Short.MAX_VALUE)
						.addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
						.addComponent(jButtonAddSong, javax.swing.GroupLayout.PREFERRED_SIZE, 37,
								javax.swing.GroupLayout.PREFERRED_SIZE)
						.addContainerGap()));

		javax.swing.GroupLayout jPanel8Layout = new javax.swing.GroupLayout(jPanel8);
		jPanel8.setLayout(jPanel8Layout);
		jPanel8Layout.setHorizontalGroup(jPanel8Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel8Layout.createSequentialGroup().addContainerGap()
						.addComponent(jPanel9, javax.swing.GroupLayout.DEFAULT_SIZE,
								javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
						.addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
						.addComponent(jPanel10, javax.swing.GroupLayout.DEFAULT_SIZE, 324, Short.MAX_VALUE)
						.addContainerGap()));
		jPanel8Layout.setVerticalGroup(jPanel8Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel8Layout.createSequentialGroup()
						.addContainerGap()
						.addGroup(jPanel8Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
								.addComponent(jPanel9, javax.swing.GroupLayout.DEFAULT_SIZE, 574, Short.MAX_VALUE)
								.addComponent(jPanel10, javax.swing.GroupLayout.PREFERRED_SIZE, 574,
										javax.swing.GroupLayout.PREFERRED_SIZE))
						.addContainerGap(14, Short.MAX_VALUE)));

		javax.swing.GroupLayout jPanel2Layout = new javax.swing.GroupLayout(jPanel2);
		jPanel2.setLayout(jPanel2Layout);
		jPanel2Layout.setHorizontalGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel2Layout.createSequentialGroup().addContainerGap()
						.addComponent(jPanel8, javax.swing.GroupLayout.DEFAULT_SIZE, 1129, Short.MAX_VALUE)
						.addContainerGap()));
		jPanel2Layout.setVerticalGroup(jPanel2Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel2Layout.createSequentialGroup().addContainerGap()
						.addComponent(jPanel8, javax.swing.GroupLayout.DEFAULT_SIZE, 603, Short.MAX_VALUE)
						.addContainerGap()));

		jTabbedPane6.addTab("Bài hát", jPanel2);

		jPanel35.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));

		jPanel36.setPreferredSize(new java.awt.Dimension(772, 572));

		jTableRequest.setModel(new javax.swing.table.DefaultTableModel(null, new String[] {"Mã YC", "Người yêu cầu",
				"Ngày yêu cầu", "Tên bài hát", "Ca sĩ", "Nhạc sĩ", "Trạng thái" }));
		jTableRequest.setAutoscrolls(false);
		jScrollPane13.setViewportView(jTableRequest);
		
		jButtonDeleteRequest.setText("Xóa");
		jButtonDeleteRequest.addActionListener(this);

		jLabel15.setFont(new java.awt.Font("Times New Roman", 0, 24)); 
		jLabel15.setText("DANH SÁCH YÊU CẦU");

		javax.swing.GroupLayout jPanel36Layout = new javax.swing.GroupLayout(jPanel36);
		jPanel36.setLayout(jPanel36Layout);
		jPanel36Layout.setHorizontalGroup(jPanel36Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel36Layout.createSequentialGroup().addContainerGap()
						.addGroup(jPanel36Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
								.addGroup(jPanel36Layout.createSequentialGroup().addComponent(jScrollPane13)
										.addContainerGap())
								.addGroup(javax.swing.GroupLayout.Alignment.TRAILING,
										jPanel36Layout.createSequentialGroup().addGap(0, 261, Short.MAX_VALUE)
												.addComponent(jLabel15).addGap(254, 254, 254))))
				.addGroup(javax.swing.GroupLayout.Alignment.TRAILING,
						jPanel36Layout.createSequentialGroup()
								.addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
								.addComponent(jButtonDeleteRequest, javax.swing.GroupLayout.PREFERRED_SIZE, 113,
										javax.swing.GroupLayout.PREFERRED_SIZE)
								.addContainerGap()));
		jPanel36Layout.setVerticalGroup(jPanel36Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel36Layout.createSequentialGroup().addContainerGap().addComponent(jLabel15)
						.addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
						.addComponent(jScrollPane13, javax.swing.GroupLayout.DEFAULT_SIZE, 469, Short.MAX_VALUE)
						.addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
						.addComponent(jButtonDeleteRequest, javax.swing.GroupLayout.PREFERRED_SIZE, 37,
								javax.swing.GroupLayout.PREFERRED_SIZE)
						.addContainerGap()));

		jPanel37.setPreferredSize(new java.awt.Dimension(315, 575));

		jLabel16.setFont(new java.awt.Font("Times New Roman", 0, 24)); 
		jLabel16.setText("THÊM YÊU CẦU");

		jPanel40.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));

		jLabel19.setFont(new java.awt.Font("Times New Roman", 0, 14)); 
		jLabel19.setText("Người yêu cầu*");

		jTextFieldRequester.setFont(new java.awt.Font("Times New Roman", 0, 14)); 

		jLabel4.setFont(new java.awt.Font("Times New Roman", 0, 14)); 
		jLabel4.setText("Phần sau 'SO' mã bài hát*");

		jTextFieldSongId.setFont(new java.awt.Font("Times New Roman", 0, 14)); 

		jLabel6.setFont(new java.awt.Font("Times New Roman", 0, 14)); 
		jLabel6.setText("Số điện thoại*");

		jTextFieldRequesterPhone.setFont(new java.awt.Font("Times New Roman", 0, 14)); 

		jLabel7.setFont(new java.awt.Font("Times New Roman", 0, 14)); 
		jLabel7.setText("Lời nhắn:");

		jTextAreaRequesterMessage.setColumns(20);
		jTextAreaRequesterMessage.setRows(5);
		jScrollPane3.setViewportView(jTextAreaRequesterMessage);

		javax.swing.GroupLayout jPanel40Layout = new javax.swing.GroupLayout(jPanel40);
		jPanel40.setLayout(jPanel40Layout);
		jPanel40Layout.setHorizontalGroup(jPanel40Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel40Layout.createSequentialGroup().addContainerGap()
						.addGroup(jPanel40Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
								.addComponent(jScrollPane3)
								.addGroup(jPanel40Layout.createSequentialGroup()
										.addGroup(jPanel40Layout
												.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING, false)
												.addComponent(jLabel7, javax.swing.GroupLayout.Alignment.LEADING,
														javax.swing.GroupLayout.DEFAULT_SIZE,
														javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
												.addComponent(jLabel6, javax.swing.GroupLayout.DEFAULT_SIZE,
														javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
												.addComponent(jLabel4, javax.swing.GroupLayout.DEFAULT_SIZE,
														javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
												.addComponent(jLabel19, javax.swing.GroupLayout.DEFAULT_SIZE,
														javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
										.addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED,
												javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
										.addGroup(jPanel40Layout
												.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
												.addComponent(jTextFieldRequesterPhone,
														javax.swing.GroupLayout.DEFAULT_SIZE, 161, Short.MAX_VALUE)
												.addComponent(jTextFieldRequester).addComponent(jTextFieldSongId))))
						.addContainerGap()));
		jPanel40Layout.setVerticalGroup(jPanel40Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel40Layout.createSequentialGroup().addGap(30, 30, 30)
						.addGroup(jPanel40Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
								.addComponent(jLabel19)
								.addComponent(jTextFieldRequester, javax.swing.GroupLayout.PREFERRED_SIZE,
										javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
						.addGap(18, 18, 18)
						.addGroup(jPanel40Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
								.addComponent(jLabel4)
								.addComponent(jTextFieldSongId, javax.swing.GroupLayout.PREFERRED_SIZE,
										javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
						.addGap(18, 18, 18)
						.addGroup(jPanel40Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
								.addComponent(jLabel6).addComponent(jTextFieldRequesterPhone,
										javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE,
										javax.swing.GroupLayout.PREFERRED_SIZE))
						.addGap(18, 18, 18).addComponent(jLabel7)
						.addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
						.addComponent(jScrollPane3, javax.swing.GroupLayout.DEFAULT_SIZE, 277, Short.MAX_VALUE)
						.addContainerGap()));

		jButtonAddRequest.setText("Thêm");
		jButtonAddRequest.setMaximumSize(new java.awt.Dimension(55, 25));
		jButtonAddRequest.setMinimumSize(new java.awt.Dimension(55, 25));
		jButtonAddRequest.setPreferredSize(new java.awt.Dimension(55, 25));
		jButtonAddRequest.addActionListener(this);

		javax.swing.GroupLayout jPanel37Layout = new javax.swing.GroupLayout(jPanel37);
		jPanel37.setLayout(jPanel37Layout);
		jPanel37Layout.setHorizontalGroup(jPanel37Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel37Layout.createSequentialGroup().addGap(72, 72, 72).addComponent(jLabel16).addGap(0, 76,
						Short.MAX_VALUE))
				.addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel37Layout.createSequentialGroup()
						.addContainerGap()
						.addGroup(jPanel37Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
								.addComponent(jPanel40, javax.swing.GroupLayout.Alignment.TRAILING,
										javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE,
										Short.MAX_VALUE)
								.addGroup(javax.swing.GroupLayout.Alignment.TRAILING,
										jPanel37Layout.createSequentialGroup().addGap(0, 0, Short.MAX_VALUE)
												.addComponent(jButtonAddRequest, javax.swing.GroupLayout.PREFERRED_SIZE,
														113, javax.swing.GroupLayout.PREFERRED_SIZE)))
						.addContainerGap()));
		jPanel37Layout.setVerticalGroup(jPanel37Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel37Layout.createSequentialGroup().addContainerGap().addComponent(jLabel16)
						.addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
						.addComponent(jPanel40, javax.swing.GroupLayout.DEFAULT_SIZE,
								javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
						.addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
						.addComponent(jButtonAddRequest, javax.swing.GroupLayout.PREFERRED_SIZE, 37,
								javax.swing.GroupLayout.PREFERRED_SIZE)
						.addContainerGap()));

		javax.swing.GroupLayout jPanel35Layout = new javax.swing.GroupLayout(jPanel35);
		jPanel35.setLayout(jPanel35Layout);
		jPanel35Layout.setHorizontalGroup(jPanel35Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel35Layout.createSequentialGroup().addContainerGap()
						.addComponent(jPanel36, javax.swing.GroupLayout.DEFAULT_SIZE,
								javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
						.addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
						.addComponent(jPanel37, javax.swing.GroupLayout.DEFAULT_SIZE, 324, Short.MAX_VALUE)
						.addContainerGap()));
		jPanel35Layout.setVerticalGroup(jPanel35Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel35Layout.createSequentialGroup().addContainerGap()
						.addGroup(jPanel35Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
								.addComponent(jPanel36, javax.swing.GroupLayout.PREFERRED_SIZE, 574,
										javax.swing.GroupLayout.PREFERRED_SIZE)
								.addComponent(jPanel37, javax.swing.GroupLayout.PREFERRED_SIZE, 574,
										javax.swing.GroupLayout.PREFERRED_SIZE))
						.addGap(14, 14, 14)));

		javax.swing.GroupLayout jPanel3Layout = new javax.swing.GroupLayout(jPanel3);
		jPanel3.setLayout(jPanel3Layout);
		jPanel3Layout.setHorizontalGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel3Layout.createSequentialGroup().addContainerGap().addComponent(jPanel35,
						javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
						.addContainerGap()));
		jPanel3Layout.setVerticalGroup(jPanel3Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel3Layout.createSequentialGroup().addContainerGap().addComponent(jPanel35,
						javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
						.addContainerGap()));

		jTabbedPane6.addTab("Yêu cầu", jPanel3);

		jPanel14.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));

		jTableUnresolvedSong.setModel(new javax.swing.table.DefaultTableModel(null,
				new String[] { "STT", "Mã bài hát", "Tên bài hát", "Số lượt yêu cầu" }));
		jScrollPane14.setViewportView(jTableUnresolvedSong);

		jLabel5.setFont(new java.awt.Font("Times New Roman", 0, 24)); 
		jLabel5.setText("BÀI HÁT CHƯA ĐƯỢC PHÁT");

		javax.swing.GroupLayout jPanel15Layout = new javax.swing.GroupLayout(jPanel15);
		jPanel15.setLayout(jPanel15Layout);
		jPanel15Layout.setHorizontalGroup(jPanel15Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel15Layout.createSequentialGroup().addGap(42, 42, 42).addComponent(jLabel5)
						.addContainerGap(49, Short.MAX_VALUE)));
		jPanel15Layout.setVerticalGroup(jPanel15Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel15Layout.createSequentialGroup().addContainerGap().addComponent(jLabel5)
						.addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)));

		jTableFavoriteSong.setModel(new javax.swing.table.DefaultTableModel(null,
				new String[] { "STT", "Mã bài hát", "Tên bài hát", "Số lượt yêu cầu" }));
		jScrollPane15.setViewportView(jTableFavoriteSong);

		jLabel17.setFont(new java.awt.Font("Times New Roman", 0, 24)); 
		jLabel17.setText("BÀI HÁT ĐƯỢC ƯA THÍCH");

		javax.swing.GroupLayout jPanel34Layout = new javax.swing.GroupLayout(jPanel34);
		jPanel34.setLayout(jPanel34Layout);
		jPanel34Layout.setHorizontalGroup(jPanel34Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel34Layout.createSequentialGroup().addGap(55, 55, 55).addComponent(jLabel17)
						.addContainerGap(59, Short.MAX_VALUE)));
		jPanel34Layout.setVerticalGroup(jPanel34Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel34Layout.createSequentialGroup().addContainerGap().addComponent(jLabel17)
						.addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)));

		jTableRequestExceptions.setModel(
				new javax.swing.table.DefaultTableModel(null, new String[] { "Tên thính giả", "Mã bài hát", "Lý do" }));
		jScrollPane16.setViewportView(jTableRequestExceptions);

		jLabel18.setFont(new java.awt.Font("Times New Roman", 0, 24)); 
		jLabel18.setText("KHÔNG ĐÁP ỨNG");

		javax.swing.GroupLayout jPanel38Layout = new javax.swing.GroupLayout(jPanel38);
		jPanel38.setLayout(jPanel38Layout);
		jPanel38Layout.setHorizontalGroup(jPanel38Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel38Layout.createSequentialGroup()
						.addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE).addComponent(jLabel18,
								javax.swing.GroupLayout.PREFERRED_SIZE, 222, javax.swing.GroupLayout.PREFERRED_SIZE)
						.addContainerGap()));
		jPanel38Layout.setVerticalGroup(jPanel38Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(javax.swing.GroupLayout.Alignment.TRAILING,
						jPanel38Layout.createSequentialGroup()
								.addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
								.addComponent(jLabel18).addContainerGap()));

		jButtonBroadCast.setText("PHÁT SÓNG");
		jButtonBroadCast.addActionListener(this);

		javax.swing.GroupLayout jPanel14Layout = new javax.swing.GroupLayout(jPanel14);
		jPanel14.setLayout(jPanel14Layout);
		jPanel14Layout.setHorizontalGroup(jPanel14Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel14Layout.createSequentialGroup()
						.addContainerGap()
						.addGroup(jPanel14Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
								.addGroup(jPanel14Layout.createSequentialGroup().addGap(0, 0, Short.MAX_VALUE)
										.addComponent(jPanel34, javax.swing.GroupLayout.PREFERRED_SIZE,
												javax.swing.GroupLayout.DEFAULT_SIZE,
												javax.swing.GroupLayout.PREFERRED_SIZE))
								.addComponent(jScrollPane15, javax.swing.GroupLayout.PREFERRED_SIZE, 0,
										Short.MAX_VALUE))
						.addGap(18, 18, 18)
						.addGroup(jPanel14Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
								.addGroup(jPanel14Layout.createSequentialGroup()
										.addComponent(jPanel15, javax.swing.GroupLayout.PREFERRED_SIZE,
												javax.swing.GroupLayout.DEFAULT_SIZE,
												javax.swing.GroupLayout.PREFERRED_SIZE)
										.addGap(18, 18, 18).addComponent(jPanel38, javax.swing.GroupLayout.DEFAULT_SIZE,
												javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
								.addGroup(jPanel14Layout.createSequentialGroup().addGroup(jPanel14Layout
										.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
										.addGroup(jPanel14Layout.createSequentialGroup()
												.addComponent(jScrollPane14, javax.swing.GroupLayout.PREFERRED_SIZE,
														330, javax.swing.GroupLayout.PREFERRED_SIZE)
												.addGap(18, 18, 18))
										.addGroup(javax.swing.GroupLayout.Alignment.TRAILING,
												jPanel14Layout.createSequentialGroup().addComponent(jButtonBroadCast)
														.addGap(106, 106, 106)))
										.addComponent(jScrollPane16, javax.swing.GroupLayout.PREFERRED_SIZE, 330,
												javax.swing.GroupLayout.PREFERRED_SIZE)))
						.addGap(722, 722, 722)));
		jPanel14Layout.setVerticalGroup(jPanel14Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel14Layout.createSequentialGroup()
						.addContainerGap()
						.addGroup(jPanel14Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
								.addComponent(jPanel15, javax.swing.GroupLayout.DEFAULT_SIZE,
										javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
								.addComponent(jPanel34, javax.swing.GroupLayout.DEFAULT_SIZE,
										javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
								.addComponent(jPanel38, javax.swing.GroupLayout.DEFAULT_SIZE,
										javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
						.addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
						.addGroup(jPanel14Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
								.addComponent(jScrollPane16)
								.addComponent(jScrollPane15, javax.swing.GroupLayout.DEFAULT_SIZE, 501, Short.MAX_VALUE)
								.addGroup(javax.swing.GroupLayout.Alignment.TRAILING,
										jPanel14Layout.createSequentialGroup().addComponent(jScrollPane14)
												.addGap(18, 18, 18).addComponent(jButtonBroadCast,
														javax.swing.GroupLayout.PREFERRED_SIZE, 37,
														javax.swing.GroupLayout.PREFERRED_SIZE)))
						.addContainerGap(20, Short.MAX_VALUE)));

		javax.swing.GroupLayout jPanel4Layout = new javax.swing.GroupLayout(jPanel4);
		jPanel4.setLayout(jPanel4Layout);
		jPanel4Layout.setHorizontalGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel4Layout.createSequentialGroup().addContainerGap()
						.addComponent(jPanel14, javax.swing.GroupLayout.PREFERRED_SIZE, 1129, Short.MAX_VALUE)
						.addContainerGap()));
		jPanel4Layout.setVerticalGroup(jPanel4Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel4Layout.createSequentialGroup().addContainerGap().addComponent(jPanel14,
						javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
						.addContainerGap()));

		jTabbedPane6.addTab("Tra cứu", jPanel4);

		jMenu1.setText("View");

		jMenuItem1.setText("Always on top");
		jMenu1.add(jMenuItem1);

		jMenuItem2.setText("Sắp xếp");
		jMenu1.add(jMenuItem2);

		jMenuBar1.add(jMenu1);

		jMenu2.setText("Option");

		jMenuItem3.setLabel("Option 1");
		jMenu2.add(jMenuItem3);

		jMenu4.setLabel("Option 2");
		jMenu2.add(jMenu4);

		jMenuItem4.setLabel("Option 3");
		jMenu2.add(jMenuItem4);

		jMenuBar1.add(jMenu2);

		jMenu3.setText("Help");

		jMenuItem5.setLabel("Hướng dẫn sử dụng");
		jMenu3.add(jMenuItem5);

		jMenuItem6.setText("Giới thiệu");
		jMenu3.add(jMenuItem6);

		jMenuBar1.add(jMenu3);

		setJMenuBar(jMenuBar1);

		javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
		getContentPane().setLayout(layout);
		layout.setHorizontalGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(layout.createSequentialGroup().addContainerGap().addComponent(jTabbedPane6,
						javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
						.addContainerGap()));
		layout.setVerticalGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(layout.createSequentialGroup().addContainerGap()
						.addComponent(jTabbedPane6, javax.swing.GroupLayout.DEFAULT_SIZE, 665, Short.MAX_VALUE)
						.addContainerGap()));

		pack();
	}// </editor-fold>//GEN-END:initComponents

	/**
	 * @param args
	 *            the command line arguments
	 */
	public static void main(String args[]) {
		/* Set the Nimbus look and feel */
		// <editor-fold defaultstate="collapsed" desc=" Look and feel setting code
		// (optional) ">
		/*
		 * If Nimbus (introduced in Java SE 6) is not available, stay with the default
		 * look and feel. For details see
		 * http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html
		 */
		try {
			for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
				if ("Nimbus".equals(info.getName())) {
					javax.swing.UIManager.setLookAndFeel(info.getClassName());
					break;
				}
			}
		} catch (ClassNotFoundException ex) {
			java.util.logging.Logger.getLogger(Main.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
		} catch (InstantiationException ex) {
			java.util.logging.Logger.getLogger(Main.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
		} catch (IllegalAccessException ex) {
			java.util.logging.Logger.getLogger(Main.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
		} catch (javax.swing.UnsupportedLookAndFeelException ex) {
			java.util.logging.Logger.getLogger(Main.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
		}
		// </editor-fold>

		/* Create and display the form */
		java.awt.EventQueue.invokeLater(new Runnable() {
			public void run() {
				new Main().setVisible(true);
			}
		});
	}

	// Variables declaration - do not modify//GEN-BEGIN:variables
	private javax.swing.JButton jButtonPlayBroadcast;
	private javax.swing.JButton jButtonDeleteRequest;
	private javax.swing.JButton jButtonAddRequest;
	private javax.swing.JButton jButtonAddSong;
	private javax.swing.JButton jButtonFileChoosing;
	private javax.swing.JButton jButtonBroadCast;
	private javax.swing.JButton jButtonDeselected;
	private javax.swing.JLabel jLabel1;
	private javax.swing.JLabel jLabel10;
	private javax.swing.JLabel jLabel11;
	private javax.swing.JLabel jLabel13;
	private javax.swing.JLabel jLabel15;
	private javax.swing.JLabel jLabel16;
	private javax.swing.JLabel jLabel17;
	private javax.swing.JLabel jLabel18;
	private javax.swing.JLabel jLabel19;
	private javax.swing.JLabel jLabel2;
	private javax.swing.JLabel jLabel3;
	private javax.swing.JLabel jLabel4;
	private javax.swing.JLabel jLabel5;
	private javax.swing.JLabel jLabel6;
	private javax.swing.JLabel jLabel7;
	private javax.swing.JLabel jLabel8;
	private javax.swing.JLabel jLabel9;
	private javax.swing.JMenu jMenu1;
	private javax.swing.JMenu jMenu2;
	private javax.swing.JMenu jMenu3;
	private javax.swing.JMenu jMenu4;
	private javax.swing.JMenuBar jMenuBar1;
	private javax.swing.JMenuItem jMenuItem1;
	private javax.swing.JMenuItem jMenuItem2;
	private javax.swing.JMenuItem jMenuItem3;
	private javax.swing.JMenuItem jMenuItem4;
	private javax.swing.JMenuItem jMenuItem5;
	private javax.swing.JMenuItem jMenuItem6;
	private javax.swing.JPanel jPanel1;
	private javax.swing.JPanel jPanel12;

	private javax.swing.JPanel jPanel10;
	private javax.swing.JPanel jPanel11;
	private javax.swing.JPanel jPanel14;
	private javax.swing.JPanel jPanel15;
	private javax.swing.JPanel jPanel2;
	private javax.swing.JPanel jPanel3;
	private javax.swing.JPanel jPanel34;
	private javax.swing.JPanel jPanel35;
	private javax.swing.JPanel jPanel36;
	private javax.swing.JPanel jPanel37;
	private javax.swing.JPanel jPanel38;
	private javax.swing.JPanel jPanel4;
	private javax.swing.JPanel jPanel40;
	private javax.swing.JPanel jPanel5;
	private javax.swing.JPanel jPanel6;
	private javax.swing.JPanel jPanel7;
	private javax.swing.JPanel jPanel8;
	private javax.swing.JPanel jPanel9;
	private javax.swing.JScrollPane jScrollPane1;
	private javax.swing.JScrollPane jScrollPane13;
	private javax.swing.JScrollPane jScrollPane14;
	private javax.swing.JScrollPane jScrollPane15;
	private javax.swing.JScrollPane jScrollPane5;
	private javax.swing.JScrollPane jScrollPane16;
	private javax.swing.JScrollPane jScrollPane2;
	private javax.swing.JScrollPane jScrollPane3;
//	private javax.swing.JScrollPane jScrollPane4;
	private javax.swing.JTabbedPane jTabbedPane6;
	private javax.swing.JTable jTableBroadcasts;
	private javax.swing.JTable jTableBroadcastRequest;
	private javax.swing.JTable jTableRequest;
	private javax.swing.JTable jTableUnresolvedSong;
	private javax.swing.JTable jTableFavoriteSong;
	private javax.swing.JTable jTableRequestExceptions;
	private javax.swing.JTable jTableSong;
	private javax.swing.JTextArea jTextAreaRequesterMessage;
	private javax.swing.JTextField jTextFieldRequester;
	private javax.swing.JTextField jTextFieldSongId;
	private javax.swing.JTextField jTextFieldRequesterPhone;
	// private javax.swing.JTextField jTextFieldSongCode;
	private javax.swing.JTextField jTextFieldSongName;
	private javax.swing.JTextField jTextFieldComposerName;
	private javax.swing.JTextField jTextFieldSingerName;
	private javax.swing.JTextField jTextFieldLink;
	private Mixer mixer;
	private Clip clip;
	// End of variables declaration//GEN-END:variables
	JFileChooser chooser;
	String choosertitle;
	private String selectedSongId;
	private Song selectedSong;

	public void music(String source) {
		Mixer.Info[] mixInfos = AudioSystem.getMixerInfo();

		mixer = AudioSystem.getMixer(mixInfos[0]);
		DataLine.Info dataInfo = new DataLine.Info(Clip.class, null);
		try {
			clip = (Clip) mixer.getLine(dataInfo);
		} catch (LineUnavailableException lue) {
			lue.printStackTrace();
		}

		try {
			URL soundURL = Main.class.getResource(source);
			AudioInputStream audioStream = AudioSystem.getAudioInputStream(soundURL);
			if(clip.isRunning())
				clip.stop();
			clip.open(audioStream);
		} catch (LineUnavailableException lue) {
			lue.printStackTrace();
		} catch (UnsupportedAudioFileException uafe) {
			uafe.printStackTrace();
		} catch (IOException ioe) {
			ioe.printStackTrace();
		}
		clip.start();
	}

	public void selectSong(String songId) {
		selectedSongId = songId;
		jButtonAddSong.setText("Sửa");
		selectedSong = new DataProvider().song(songId);
		jTextFieldSongName.setText(selectedSong.getName());
		jTextFieldComposerName.setText(selectedSong.getComposer());
		jTextFieldSingerName.setText(selectedSong.getSinger());
		jTextFieldLink.setText(selectedSong.getLink());
	}

	public void actionPerformed(ActionEvent e) {
		if (e.getSource() == jButtonAddSong) {
			if (jTextFieldSongName.getText().equals("") || jTextFieldComposerName.getText().equals("")
					|| jTextFieldSingerName.getText().equals("")) {
				javax.swing.JOptionPane.showMessageDialog(null, "Điền đầy đủ các trường có *");
				return;
			}
			DataProvider dal = new DataProvider();

			if (selectedSongId.equals("")) {
				Song song = new Song(jTextFieldSongName.getText(), jTextFieldComposerName.getText(),
						jTextFieldSingerName.getText(), jTextFieldLink.getText(), 1);
				dal.insertSong(song);
				showSongs();
			}
			else {
				selectedSong.setName(jTextFieldSongName.getText());
				selectedSong.setComposer(jTextFieldComposerName.getText());
				selectedSong.setSinger(jTextFieldSingerName.getText());
				selectedSong.setLink(jTextFieldLink.getText());
				dal.updateSong(selectedSong);
				jTableSong.setValueAt(selectedSong.getName(), jTableSong.getSelectedRow(),1);
				jTableSong.setValueAt(selectedSong.getComposer(), jTableSong.getSelectedRow(),2);
				jTableSong.setValueAt(selectedSong.getSinger(), jTableSong.getSelectedRow(),3);
			}
			jTextFieldSongName.setText("");
			jTextFieldComposerName.setText("");
			jTextFieldSingerName.setText("");
			jTextFieldLink.setText("");
		}

		if (e.getSource() == jButtonPlayBroadcast) {
			music("/UI/abc.wav");
		}

		if (e.getSource() == jButtonDeselected) {
			selectedSongId = "";
			jButtonAddSong.setText("Thêm");
			jTextFieldSongName.setText("");
			jTextFieldComposerName.setText("");
			jTextFieldSingerName.setText("");
			jTextFieldLink.setText("");
		}

		if (e.getSource() == jButtonFileChoosing) {
			chooser = new JFileChooser();
			chooser.setCurrentDirectory(new java.io.File("."));
			chooser.setDialogTitle(choosertitle);
			chooser.setFileSelectionMode(JFileChooser.FILES_ONLY);
			//
			// disable the "All files" option.
			//
			chooser.setAcceptAllFileFilterUsed(false);
			//
			if (chooser.showOpenDialog(this) == JFileChooser.APPROVE_OPTION) {
				System.out.println("getCurrentDirectory(): " + chooser.getCurrentDirectory());
				System.out.println("getSelectedFile() : " + chooser.getSelectedFile());
				jTextFieldLink.setText(chooser.getSelectedFile().getAbsolutePath());
			} else {
				System.out.println("No Selection ");
			}
		}

		if (e.getSource() == jButtonBroadCast) {
			DataProvider dal = new DataProvider();
			Broadcast broadcast = dal.insertBroadcast();
			javax.swing.JOptionPane.showMessageDialog(null, broadcast.getName());
			showRequests();
			showFavoriteSongs();
			showUnresolvedSongs();
			addToBroadcast(broadcast);
		}

		if (e.getSource() == jButtonDeleteRequest) {
			try{
				if(jTableRequest.getValueAt(jTableRequest.getSelectedRow(), 6).equals("Đã phát")) {
					javax.swing.JOptionPane.showMessageDialog(null, "Yêu cầu đã được xử lý vui lòng không xoá");
					return;
				}
				String requestId = (String) jTableRequest.getValueAt(jTableRequest.getSelectedRow(), 0);
				requestId = requestId.substring(2);
				DataProvider dal = new DataProvider();
				dal.deleteRequest(requestId);
				showRequests();
				showUnresolvedSongs();
			}
			catch(ArrayIndexOutOfBoundsException aiobe) {
				javax.swing.JOptionPane.showMessageDialog(null, "Chưa chọn yêu cầu");
			}
		}

		if (e.getSource() == jButtonAddRequest) {
			if (jTextFieldRequester.getText().equals("") || jTextFieldSongId.getText().equals("")
					|| jTextFieldRequesterPhone.getText().equals("")) {
				javax.swing.JOptionPane.showMessageDialog(null, "Điền đầy đủ các trường có *");
				return;
			}

			User user = new User(jTextFieldRequester.getText(), jTextFieldRequesterPhone.getText(), "");
			String user_id = new DataProvider().insertUser(user);
			System.out.println(jTextFieldSongId.getText());
			Request request = new Request(user_id, jTextFieldSongId.getText(), jTextAreaRequesterMessage.getText());
			jTextFieldRequesterPhone.setText("");
			jTextFieldSongId.setText("");
			jTextFieldRequester.setText("");
			jTextAreaRequesterMessage.setText("");
			DataProvider dal = new DataProvider();
			dal.insertRequest(request);
			showRequests();
			showFavoriteSongs();
			showUnresolvedSongs();
			showRequestExceptions();
		}
	}
}
