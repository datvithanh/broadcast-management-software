package UI;

import java.sql.SQLException;

import DTO.Song;

public class NewJFrame extends javax.swing.JFrame {

	public NewJFrame() {
		initComponents();
	}

	private void initComponents() {

		jTabbedPane6 = new javax.swing.JTabbedPane();
		jPanel1 = new javax.swing.JPanel();
		jPanel5 = new javax.swing.JPanel();
		jPanel6 = new javax.swing.JPanel();
		jLabel1 = new javax.swing.JLabel();
		jScrollPane1 = new javax.swing.JScrollPane();
		jTable1 = new javax.swing.JTable();
		jPanel7 = new javax.swing.JPanel();
		jButton1 = new javax.swing.JButton();
		jButton2 = new javax.swing.JButton();
		jPanel2 = new javax.swing.JPanel();
		jPanel8 = new javax.swing.JPanel();
		jPanel9 = new javax.swing.JPanel();
		jScrollPane2 = new javax.swing.JScrollPane();
		jTable2 = new javax.swing.JTable();
		jButton3 = new javax.swing.JButton();
		jLabel2 = new javax.swing.JLabel();
		jPanel10 = new javax.swing.JPanel();
		jLabel3 = new javax.swing.JLabel();
		jPanel11 = new javax.swing.JPanel();
		jLabel8 = new javax.swing.JLabel();
		jTextField4 = new javax.swing.JTextField();
		jLabel20 = new javax.swing.JLabel();
		jTextField5 = new javax.swing.JTextField();
		jLabel9 = new javax.swing.JLabel();
		jTextField6 = new javax.swing.JTextField();
		jLabel10 = new javax.swing.JLabel();
		jTextField7 = new javax.swing.JTextField();
		jLabel11 = new javax.swing.JLabel();
		jTextField8 = new javax.swing.JTextField();
		jButton5 = new javax.swing.JButton();
		jLabel12 = new javax.swing.JLabel();
		jScrollPane4 = new javax.swing.JScrollPane();
		jTextArea2 = new javax.swing.JTextArea();
		jButton4 = new javax.swing.JButton();
		jPanel3 = new javax.swing.JPanel();
		jPanel35 = new javax.swing.JPanel();
		jPanel36 = new javax.swing.JPanel();
		jScrollPane13 = new javax.swing.JScrollPane();
		jTable13 = new javax.swing.JTable();
		jButton16 = new javax.swing.JButton();
		jLabel15 = new javax.swing.JLabel();
		jPanel37 = new javax.swing.JPanel();
		jLabel16 = new javax.swing.JLabel();
		jPanel40 = new javax.swing.JPanel();
		jLabel19 = new javax.swing.JLabel();
		jTextField1 = new javax.swing.JTextField();
		jLabel4 = new javax.swing.JLabel();
		jTextField2 = new javax.swing.JTextField();
		jLabel6 = new javax.swing.JLabel();
		jTextField3 = new javax.swing.JTextField();
		jLabel7 = new javax.swing.JLabel();
		jScrollPane3 = new javax.swing.JScrollPane();
		jTextArea1 = new javax.swing.JTextArea();
		jButton17 = new javax.swing.JButton();
		jPanel4 = new javax.swing.JPanel();
		jPanel14 = new javax.swing.JPanel();
		jScrollPane14 = new javax.swing.JScrollPane();
		jTable14 = new javax.swing.JTable();
		jPanel15 = new javax.swing.JPanel();
		jLabel5 = new javax.swing.JLabel();
		jScrollPane15 = new javax.swing.JScrollPane();
		jTable15 = new javax.swing.JTable();
		jPanel34 = new javax.swing.JPanel();
		jLabel17 = new javax.swing.JLabel();
		jScrollPane16 = new javax.swing.JScrollPane();
		jTable16 = new javax.swing.JTable();
		jPanel38 = new javax.swing.JPanel();
		jLabel18 = new javax.swing.JLabel();
		jButton6 = new javax.swing.JButton();
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

		setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
		setResizable(false);

		jTabbedPane6.setAutoscrolls(true);
		jTabbedPane6.setFocusable(false);
		jTabbedPane6.setFont(new java.awt.Font("Times New Roman", 0, 18)); // NOI18N
		jTabbedPane6.setPreferredSize(new java.awt.Dimension(1156, 601));

		jPanel5.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));

		jLabel1.setFont(new java.awt.Font("Times New Roman", 0, 24)); // NOI18N
		jLabel1.setText("DANH SÁCH PHÁT");

		javax.swing.GroupLayout jPanel6Layout = new javax.swing.GroupLayout(jPanel6);
		jPanel6.setLayout(jPanel6Layout);
		jPanel6Layout.setHorizontalGroup(jPanel6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel6Layout.createSequentialGroup().addGap(436, 436, 436).addComponent(jLabel1)
						.addContainerGap(463, Short.MAX_VALUE)));
		jPanel6Layout.setVerticalGroup(jPanel6Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel6Layout.createSequentialGroup()
						.addContainerGap(29, Short.MAX_VALUE).addComponent(jLabel1).addContainerGap()));

		jTable1.setModel(new javax.swing.table.DefaultTableModel(
				new Object[][] { { null, null, null, null, null }, { null, null, null, null, null },
						{ null, null, null, null, null }, { null, null, null, null, null } },
				new String[] { "Số thứ tự", "Tên bài hát", "Ngày phát", "Ca sĩ", "Nhạc sĩ" }));
		jScrollPane1.setViewportView(jTable1);

		jButton1.setText("PLAY");

		jButton2.setText("NEXT");

		javax.swing.GroupLayout jPanel7Layout = new javax.swing.GroupLayout(jPanel7);
		jPanel7.setLayout(jPanel7Layout);
		jPanel7Layout.setHorizontalGroup(jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel7Layout.createSequentialGroup().addContainerGap()
						.addComponent(jButton1, javax.swing.GroupLayout.PREFERRED_SIZE, 76,
								javax.swing.GroupLayout.PREFERRED_SIZE)
						.addGap(18, 18, 18).addComponent(jButton2)
						.addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)));
		jPanel7Layout.setVerticalGroup(jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel7Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
						.addComponent(jButton1, javax.swing.GroupLayout.DEFAULT_SIZE, 56, Short.MAX_VALUE)
						.addComponent(jButton2)));

		javax.swing.GroupLayout jPanel5Layout = new javax.swing.GroupLayout(jPanel5);
		jPanel5.setLayout(jPanel5Layout);
		jPanel5Layout.setHorizontalGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(javax.swing.GroupLayout.Alignment.TRAILING,
						jPanel5Layout.createSequentialGroup().addContainerGap()
								.addGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
										.addComponent(jPanel7, javax.swing.GroupLayout.DEFAULT_SIZE,
												javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
										.addComponent(jPanel6, javax.swing.GroupLayout.Alignment.LEADING,
												javax.swing.GroupLayout.DEFAULT_SIZE,
												javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
										.addComponent(jScrollPane1, javax.swing.GroupLayout.Alignment.LEADING))
								.addContainerGap()));
		jPanel5Layout.setVerticalGroup(jPanel5Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel5Layout.createSequentialGroup().addContainerGap()
						.addComponent(jPanel6, javax.swing.GroupLayout.PREFERRED_SIZE,
								javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
						.addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
						.addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 423, Short.MAX_VALUE)
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
		Song song = new Song();
		Object[][] songArray = null;
		try {
			songArray = song.getSongArray();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		jTable2.setModel(new javax.swing.table.DefaultTableModel(
				new Object[][] { { null, null, null, null, null }, { null, null, null, null, null },
						{ null, null, null, null, null }, { null, null, null, null, null } },
				new String[] { "STT", "Tên bài hát", "Tên nhạc sĩ", "Tên ca sĩ" }));
		jTable2.setAutoscrolls(false);
		jScrollPane2.setViewportView(jTable2);

		jButton3.setText("Xóa");

		jLabel2.setFont(new java.awt.Font("Times New Roman", 0, 24)); // NOI18N
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
												.addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel9Layout
														.createSequentialGroup()
														.addComponent(jButton3, javax.swing.GroupLayout.PREFERRED_SIZE,
																113, javax.swing.GroupLayout.PREFERRED_SIZE)
														.addContainerGap()))))));
		jPanel9Layout.setVerticalGroup(jPanel9Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel9Layout.createSequentialGroup().addContainerGap().addComponent(jLabel2)
						.addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED).addComponent(jScrollPane2)
						.addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED).addComponent(jButton3,
								javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE)
						.addContainerGap()));

		jPanel10.setPreferredSize(new java.awt.Dimension(315, 575));

		jLabel3.setFont(new java.awt.Font("Times New Roman", 0, 24)); // NOI18N
		jLabel3.setText("THÊM BÀI HÁT");

		jPanel11.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));
		jPanel11.setPreferredSize(new java.awt.Dimension(192, 451));

		jLabel8.setFont(new java.awt.Font("Times New Roman", 0, 14)); // NOI18N
		jLabel8.setText("Tên bài hát:");

		jTextField4.setFont(new java.awt.Font("Times New Roman", 0, 14)); // NOI18N

		jLabel20.setFont(new java.awt.Font("Times New Roman", 0, 14)); // NOI18N
		jLabel20.setText("Mã bài hát:");

		jTextField5.setFont(new java.awt.Font("Times New Roman", 0, 14)); // NOI18N

		jLabel9.setFont(new java.awt.Font("Times New Roman", 0, 14)); // NOI18N
		jLabel9.setText("Tên nhạc sĩ:");

		jTextField6.setFont(new java.awt.Font("Times New Roman", 0, 14)); // NOI18N

		jLabel10.setFont(new java.awt.Font("Times New Roman", 0, 14)); // NOI18N
		jLabel10.setText("Tên ca sĩ:");

		jLabel11.setFont(new java.awt.Font("Times New Roman", 0, 14)); // NOI18N
		jLabel11.setText("Đường dẫn:");

		jTextField8.setFont(new java.awt.Font("Tahoma", 0, 14)); // NOI18N

		jButton5.setText("...");

		jLabel12.setFont(new java.awt.Font("Times New Roman", 0, 14)); // NOI18N
		jLabel12.setText("Ghi chú:");

		jTextArea2.setColumns(20);
		jTextArea2.setRows(5);
		jScrollPane4.setViewportView(jTextArea2);

		javax.swing.GroupLayout jPanel11Layout = new javax.swing.GroupLayout(jPanel11);
		jPanel11.setLayout(jPanel11Layout);
		jPanel11Layout.setHorizontalGroup(jPanel11Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel11Layout.createSequentialGroup()
						.addContainerGap()
						.addGroup(jPanel11Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
								.addComponent(jScrollPane4)
								.addGroup(jPanel11Layout.createSequentialGroup().addGroup(jPanel11Layout
										.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
										.addComponent(jLabel9, javax.swing.GroupLayout.DEFAULT_SIZE,
												javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
										.addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel11Layout
												.createSequentialGroup().addGap(0, 0, Short.MAX_VALUE)
												.addGroup(jPanel11Layout
														.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
														.addComponent(jLabel20, javax.swing.GroupLayout.PREFERRED_SIZE,
																82, javax.swing.GroupLayout.PREFERRED_SIZE)
														.addComponent(jLabel8, javax.swing.GroupLayout.PREFERRED_SIZE,
																82, javax.swing.GroupLayout.PREFERRED_SIZE)))
										.addComponent(jLabel10, javax.swing.GroupLayout.DEFAULT_SIZE,
												javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
										.addComponent(jLabel11, javax.swing.GroupLayout.DEFAULT_SIZE,
												javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
										.addGap(18, 18, 18)
										.addGroup(jPanel11Layout
												.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
												.addComponent(jTextField7, javax.swing.GroupLayout.DEFAULT_SIZE, 170,
														Short.MAX_VALUE)
												.addComponent(jTextField6).addComponent(jTextField5)
												.addComponent(jTextField4)))
								.addGroup(jPanel11Layout.createSequentialGroup().addGap(0, 5, Short.MAX_VALUE)
										.addGroup(jPanel11Layout
												.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
												.addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel11Layout
														.createSequentialGroup()
														.addComponent(jTextField8,
																javax.swing.GroupLayout.PREFERRED_SIZE, 223,
																javax.swing.GroupLayout.PREFERRED_SIZE)
														.addPreferredGap(
																javax.swing.LayoutStyle.ComponentPlacement.RELATED)
														.addComponent(jButton5, javax.swing.GroupLayout.PREFERRED_SIZE,
																26, javax.swing.GroupLayout.PREFERRED_SIZE))
												.addGroup(javax.swing.GroupLayout.Alignment.TRAILING,
														jPanel11Layout.createSequentialGroup().addComponent(jLabel12)
																.addGap(221, 221, 221)))))
						.addContainerGap()));
		jPanel11Layout.setVerticalGroup(jPanel11Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel11Layout.createSequentialGroup().addGap(28, 28, 28)
						.addGroup(jPanel11Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
								.addComponent(jLabel20)
								.addComponent(jTextField4, javax.swing.GroupLayout.PREFERRED_SIZE,
										javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
						.addGap(18, 18, 18)
						.addGroup(jPanel11Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
								.addComponent(jLabel8).addComponent(jTextField5, javax.swing.GroupLayout.PREFERRED_SIZE,
										javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
						.addGap(18, 18, 18)
						.addGroup(jPanel11Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
								.addComponent(jLabel9).addComponent(jTextField6, javax.swing.GroupLayout.PREFERRED_SIZE,
										javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
						.addGap(18, 18, 18)
						.addGroup(jPanel11Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
								.addComponent(jLabel10).addComponent(jTextField7,
										javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE,
										javax.swing.GroupLayout.PREFERRED_SIZE))
						.addGap(18, 18, 18).addComponent(jLabel11)
						.addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
						.addGroup(jPanel11Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
								.addComponent(jTextField8, javax.swing.GroupLayout.PREFERRED_SIZE,
										javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
								.addComponent(jButton5))
						.addGap(18, 18, 18).addComponent(jLabel12)
						.addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
						.addComponent(jScrollPane4, javax.swing.GroupLayout.DEFAULT_SIZE, 172, Short.MAX_VALUE)
						.addContainerGap()));

		jButton4.setText("Thêm");
		jButton4.setMaximumSize(new java.awt.Dimension(55, 25));
		jButton4.setMinimumSize(new java.awt.Dimension(55, 25));
		jButton4.setPreferredSize(new java.awt.Dimension(55, 25));

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
										.addGroup(javax.swing.GroupLayout.Alignment.TRAILING,
												jPanel10Layout.createSequentialGroup()
														.addComponent(jButton4, javax.swing.GroupLayout.PREFERRED_SIZE,
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
						.addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED).addComponent(jButton4,
								javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE)
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

		jTable13.setModel(new javax.swing.table.DefaultTableModel(
				new Object[][] { { null, null, null, null, null }, { null, null, null, null, null },
						{ null, null, null, null, null }, { null, null, null, null, null } },
				new String[] { "STT", "Tên bài hát", "Ngày yêu cầu", "Ca sĩ", "Nhạc sĩ" }));
		jTable13.setAutoscrolls(false);
		jScrollPane13.setViewportView(jTable13);

		jButton16.setText("Xóa");

		jLabel15.setFont(new java.awt.Font("Times New Roman", 0, 24)); // NOI18N
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
				.addGroup(javax.swing.GroupLayout.Alignment.TRAILING, jPanel36Layout.createSequentialGroup()
						.addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE).addComponent(jButton16,
								javax.swing.GroupLayout.PREFERRED_SIZE, 113, javax.swing.GroupLayout.PREFERRED_SIZE)
						.addContainerGap()));
		jPanel36Layout.setVerticalGroup(jPanel36Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel36Layout.createSequentialGroup().addContainerGap().addComponent(jLabel15)
						.addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
						.addComponent(jScrollPane13, javax.swing.GroupLayout.DEFAULT_SIZE, 469, Short.MAX_VALUE)
						.addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED).addComponent(jButton16,
								javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE)
						.addContainerGap()));

		jPanel37.setPreferredSize(new java.awt.Dimension(315, 575));

		jLabel16.setFont(new java.awt.Font("Times New Roman", 0, 24)); // NOI18N
		jLabel16.setText("THÊM YÊU CẦU");

		jPanel40.setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));

		jLabel19.setFont(new java.awt.Font("Times New Roman", 0, 14)); // NOI18N
		jLabel19.setText("Người yêu cầu:");

		jTextField1.setFont(new java.awt.Font("Times New Roman", 0, 14)); // NOI18N

		jLabel4.setFont(new java.awt.Font("Times New Roman", 0, 14)); // NOI18N
		jLabel4.setText("Mã bài hát:");

		jTextField2.setFont(new java.awt.Font("Times New Roman", 0, 14)); // NOI18N

		jLabel6.setFont(new java.awt.Font("Times New Roman", 0, 14)); // NOI18N
		jLabel6.setText("Số điện thoại");

		jTextField3.setFont(new java.awt.Font("Times New Roman", 0, 14)); // NOI18N

		jLabel7.setFont(new java.awt.Font("Times New Roman", 0, 14)); // NOI18N
		jLabel7.setText("Lời nhắn:");

		jTextArea1.setColumns(20);
		jTextArea1.setRows(5);
		jScrollPane3.setViewportView(jTextArea1);

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
												.addComponent(jTextField3, javax.swing.GroupLayout.DEFAULT_SIZE, 161,
														Short.MAX_VALUE)
												.addComponent(jTextField1).addComponent(jTextField2))))
						.addContainerGap()));
		jPanel40Layout.setVerticalGroup(jPanel40Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel40Layout.createSequentialGroup().addGap(30, 30, 30)
						.addGroup(jPanel40Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
								.addComponent(jLabel19)
								.addComponent(jTextField1, javax.swing.GroupLayout.PREFERRED_SIZE,
										javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
						.addGap(18, 18, 18)
						.addGroup(jPanel40Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
								.addComponent(jLabel4).addComponent(jTextField2, javax.swing.GroupLayout.PREFERRED_SIZE,
										javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
						.addGap(18, 18, 18)
						.addGroup(jPanel40Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
								.addComponent(jLabel6).addComponent(jTextField3, javax.swing.GroupLayout.PREFERRED_SIZE,
										javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
						.addGap(18, 18, 18).addComponent(jLabel7)
						.addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
						.addComponent(jScrollPane3, javax.swing.GroupLayout.DEFAULT_SIZE, 277, Short.MAX_VALUE)
						.addContainerGap()));

		jButton17.setText("Thêm");
		jButton17.setMaximumSize(new java.awt.Dimension(55, 25));
		jButton17.setMinimumSize(new java.awt.Dimension(55, 25));
		jButton17.setPreferredSize(new java.awt.Dimension(55, 25));

		javax.swing.GroupLayout jPanel37Layout = new javax.swing.GroupLayout(jPanel37);
		jPanel37.setLayout(jPanel37Layout);
		jPanel37Layout.setHorizontalGroup(jPanel37Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel37Layout.createSequentialGroup().addGap(72, 72, 72).addComponent(jLabel16).addGap(0, 76,
						Short.MAX_VALUE))
				.addGroup(javax.swing.GroupLayout.Alignment.TRAILING,
						jPanel37Layout.createSequentialGroup().addContainerGap()
								.addGroup(jPanel37Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
										.addComponent(jPanel40, javax.swing.GroupLayout.Alignment.TRAILING,
												javax.swing.GroupLayout.DEFAULT_SIZE,
												javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
										.addGroup(javax.swing.GroupLayout.Alignment.TRAILING,
												jPanel37Layout.createSequentialGroup().addGap(0, 0, Short.MAX_VALUE)
														.addComponent(jButton17, javax.swing.GroupLayout.PREFERRED_SIZE,
																113, javax.swing.GroupLayout.PREFERRED_SIZE)))
								.addContainerGap()));
		jPanel37Layout.setVerticalGroup(jPanel37Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel37Layout.createSequentialGroup().addContainerGap().addComponent(jLabel16)
						.addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
						.addComponent(jPanel40, javax.swing.GroupLayout.DEFAULT_SIZE,
								javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
						.addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED).addComponent(jButton17,
								javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE)
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

		jTable14.setModel(new javax.swing.table.DefaultTableModel(
				new Object[][] { { null, null, null, null }, { null, null, null, null }, { null, null, null, null },
						{ null, null, null, null } },
				new String[] { "Mã bài hát", "Tên bài hát", "Ngày yêu cầu", "Số lượt yêu cầu" }));
		jScrollPane14.setViewportView(jTable14);

		jLabel5.setFont(new java.awt.Font("Times New Roman", 0, 24)); // NOI18N
		jLabel5.setText("BÀI HÁT CHƯA ĐƯỢC PHÁT");

		javax.swing.GroupLayout jPanel15Layout = new javax.swing.GroupLayout(jPanel15);
		jPanel15.setLayout(jPanel15Layout);
		jPanel15Layout.setHorizontalGroup(jPanel15Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel15Layout.createSequentialGroup().addGap(42, 42, 42).addComponent(jLabel5)
						.addContainerGap(49, Short.MAX_VALUE)));
		jPanel15Layout.setVerticalGroup(jPanel15Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel15Layout.createSequentialGroup().addContainerGap().addComponent(jLabel5)
						.addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)));

		jTable15.setModel(new javax.swing.table.DefaultTableModel(
				new Object[][] { { null, null, null, null }, { null, null, null, null }, { null, null, null, null },
						{ null, null, null, null } },
				new String[] { "STT", "Mã bài hát", "Tên bài hát", "Số lượt yêu cầu" }));
		jScrollPane15.setViewportView(jTable15);

		jLabel17.setFont(new java.awt.Font("Times New Roman", 0, 24)); // NOI18N
		jLabel17.setText("BÀI HÁT ĐƯỢC ƯA THÍCH");

		javax.swing.GroupLayout jPanel34Layout = new javax.swing.GroupLayout(jPanel34);
		jPanel34.setLayout(jPanel34Layout);
		jPanel34Layout.setHorizontalGroup(jPanel34Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel34Layout.createSequentialGroup().addGap(55, 55, 55).addComponent(jLabel17)
						.addContainerGap(59, Short.MAX_VALUE)));
		jPanel34Layout.setVerticalGroup(jPanel34Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
				.addGroup(jPanel34Layout.createSequentialGroup().addContainerGap().addComponent(jLabel17)
						.addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)));

		jTable16.setModel(new javax.swing.table.DefaultTableModel(new Object[][] { { null, null, null },
				{ null, null, null }, { null, null, null }, { null, null, null } },
				new String[] { "Tên thính giả", "Yêu cầu", "Lý do" }));
		jScrollPane16.setViewportView(jTable16);

		jLabel18.setFont(new java.awt.Font("Times New Roman", 0, 24)); // NOI18N
		jLabel18.setText("CHƯA ĐÁP ỨNG");

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

		jButton6.setText("LÊN LỊCH PHÁT SONG KẾ TIẾP");

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
														404, javax.swing.GroupLayout.PREFERRED_SIZE)
												.addGap(18, 18, 18))
										.addGroup(javax.swing.GroupLayout.Alignment.TRAILING,
												jPanel14Layout.createSequentialGroup().addComponent(jButton6)
														.addGap(106, 106, 106)))
										.addComponent(jScrollPane16, javax.swing.GroupLayout.PREFERRED_SIZE, 256,
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
												.addGap(18, 18, 18).addComponent(jButton6,
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
			java.util.logging.Logger.getLogger(NewJFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
		} catch (InstantiationException ex) {
			java.util.logging.Logger.getLogger(NewJFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
		} catch (IllegalAccessException ex) {
			java.util.logging.Logger.getLogger(NewJFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
		} catch (javax.swing.UnsupportedLookAndFeelException ex) {
			java.util.logging.Logger.getLogger(NewJFrame.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
		}
		// </editor-fold>

		/* Create and display the form */
		java.awt.EventQueue.invokeLater(new Runnable() {
			public void run() {
				new NewJFrame().setVisible(true);
			}
		});
	}

	// Variables declaration - do not modify//GEN-BEGIN:variables
	private javax.swing.JButton jButton1;
	private javax.swing.JButton jButton16;
	private javax.swing.JButton jButton17;
	private javax.swing.JButton jButton2;
	private javax.swing.JButton jButton3;
	private javax.swing.JButton jButton4;
	private javax.swing.JButton jButton5;
	private javax.swing.JButton jButton6;
	private javax.swing.JLabel jLabel1;
	private javax.swing.JLabel jLabel10;
	private javax.swing.JLabel jLabel11;
	private javax.swing.JLabel jLabel12;
	private javax.swing.JLabel jLabel15;
	private javax.swing.JLabel jLabel16;
	private javax.swing.JLabel jLabel17;
	private javax.swing.JLabel jLabel18;
	private javax.swing.JLabel jLabel19;
	private javax.swing.JLabel jLabel2;
	private javax.swing.JLabel jLabel20;
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
	private javax.swing.JScrollPane jScrollPane16;
	private javax.swing.JScrollPane jScrollPane2;
	private javax.swing.JScrollPane jScrollPane3;
	private javax.swing.JScrollPane jScrollPane4;
	private javax.swing.JTabbedPane jTabbedPane6;
	private javax.swing.JTable jTable1;
	private javax.swing.JTable jTable13;
	private javax.swing.JTable jTable14;
	private javax.swing.JTable jTable15;
	private javax.swing.JTable jTable16;
	private javax.swing.JTable jTable2;
	private javax.swing.JTextArea jTextArea1;
	private javax.swing.JTextArea jTextArea2;
	private javax.swing.JTextField jTextField1;
	private javax.swing.JTextField jTextField2;
	private javax.swing.JTextField jTextField3;
	private javax.swing.JTextField jTextField4;
	private javax.swing.JTextField jTextField5;
	private javax.swing.JTextField jTextField6;
	private javax.swing.JTextField jTextField7;
	private javax.swing.JTextField jTextField8;
	// End of variables declaration//GEN-END:variables
}
