update DevSubSection
set vchProgrammingCode =
'
public partial class frmBingoGame : Form
    {
        Random rnd = new Random();
        List&lt;Label&gt; lstlabel = new List&lt;Label&gt;();

        List&lt;Label&gt; lstlabels = null;
        List&lt;Label&gt; lst1labels = null;
        List&lt;Label&gt; lst2labels = null;
        List&lt;Label&gt; lstFrees = null;
        List&lt;Label&gt; lst1 = null;
        List&lt;Label&gt; lst2 = null;
        List&lt;Label&gt; lst3 = null;
        List&lt;Label&gt; lst4 = null;
        List&lt;Label&gt; lst5 = null;
        List&lt;Label&gt; lst6 = null;
        List&lt;Label&gt; lst7 = null;
        List&lt;Label&gt; lst8 = null;
        List&lt;Label&gt; lst9 = null;
        List&lt;Label&gt; lst10 = null;
        List&lt;Label&gt; lst11 = null;
        List&lt;Label&gt; lst12 = null;
        List&lt;Label&gt; lst13 = null;
        List&lt;Label&gt; lst14 = null;
        List&lt;Label&gt; lst15 = null;
        List&lt;Label&gt; lst16 = null;
        List&lt;Label&gt; lst17 = null;
        List&lt;Label&gt; lst18 = null;
        List&lt;Label&gt; lst19 = null;
        List&lt;Label&gt; lst20 = null;
        List&lt;Label&gt; lst21 = null;
        List&lt;Label&gt; lst22 = null;
        List&lt;Label&gt; lst23 = null;
        List&lt;Label&gt; lst24 = null;
        List&lt;List&lt;Label&gt;&gt; lstPlayerOne = null;
        List&lt;List&lt;Label&gt;&gt; lstPlayerTwo = null;

        public frmBingoGame()
        {
            InitializeComponent();
            SetupGame();

            btnStart.Click += BtnStart_Click;
            btnNext.Click += BtnNext_Click;

        }
        private void SetupGame()
        {
            lstlabels = new List&lt;Label&gt; { lbl1, lbl2, lbl3, lbl4, lbl5, lbl6, lbl7, lbl8, lbl9, lbl10, lbl11, lbl12,lbl13, lbl14, lbl15,lbl16, lbl17, lbl18, lbl19, lbl20, lbl21, lbl22, lbl23, lbl24, lbl25, lbl26, lbl27, lbl28, lbl29, lbl30, lbl31, lbl32, lbl33, lbl34,lbl35, lbl36, lbl37, lbl38, lbl39, lbl40, lbl41, lbl42, lbl43, lbl44, lbl45, lbl46, lbl47, lbl48 };

            lst1labels = new List&lt;Label&gt; { lbl1, lbl2, lbl3, lbl4, lbl5, lbl6, lbl7, lbl8, lbl9, lbl10,lbl11, lbl12, lbl13,lbl14, lbl15, lbl16, lbl17, lbl18, lbl19, lbl20, lbl21, lbl22, lbl23, lbl24 };

            lst2labels = new List&lt;Label&gt; { lbl25, lbl26, lbl27, lbl28, lbl29, lbl30, lbl31, lbl32, lbl33,lbl34, lbl35, lbl36, lbl37, lbl38, lbl39, lbl40, lbl41, lbl42, lbl43, lbl44, lbl45, lbl46, lbl47, lbl48 };

            lstFrees = new List&lt;Label&gt; { lblFree, lblFree2 };

            lst1 = new List&lt;Label&gt; { lbl1, lbl2, lbl3, lbl4, lbl5 };
            lst2 = new List&lt;Label&gt; { lbl6, lbl7, lbl8, lbl9, lbl10 };
            lst3 = new List&lt;Label&gt; { lbl11, lbl12, lblFree, lbl13, lbl14 };
            lst4 = new List&lt;Label&gt; { lbl15, lbl16, lbl17, lbl18, lbl19 };
            lst5 = new List&lt;Label&gt; { lbl20, lbl21, lbl22, lbl23, lbl24 };
            lst6 = new List&lt;Label&gt; { lbl1, lbl6, lbl11, lbl15, lbl20 };
            lst7 = new List&lt;Label&gt; { lbl2, lbl7, lbl12, lbl16, lbl21 };
            lst8 = new List&lt;Label&gt; { lbl3, lbl8, lblFree, lbl17, lbl22 };
            lst9 = new List&lt;Label&gt; { lbl4, lbl9, lbl13, lbl18, lbl23 };
            lst10 = new List&lt;Label&gt; { lbl5, lbl10, lbl14, lbl19, lbl24 };
            lst11 = new List&lt;Label&gt; { lbl1, lbl7, lblFree, lbl18, lbl24 };
            lst12 = new List&lt;Label&gt; { lbl5, lbl9, lblFree, lbl16, lbl20 };
            lst13 = new List&lt;Label&gt; { lbl25, lbl26, lbl27, lbl28, lbl29 };
            lst14 = new List&lt;Label&gt; { lbl30, lbl31, lbl32, lbl33, lbl34 };
            lst15 = new List&lt;Label&gt; { lbl35, lbl36, lblFree2, lbl37, lbl38 };
            lst16 = new List&lt;Label&gt; { lbl39, lbl40, lbl41, lbl42, lbl43 };
            lst17 = new List&lt;Label&gt; { lbl44, lbl45, lbl46, lbl47, lbl48 };
            lst18 = new List&lt;Label&gt; { lbl25, lbl30, lbl35, lbl39, lbl44 };
            lst19 = new List&lt;Label&gt; { lbl26, lbl31, lbl36, lbl40, lbl45 };
            lst20 = new List&lt;Label&gt; { lbl27, lbl32, lblFree2, lbl41, lbl46 };
            lst21 = new List&lt;Label&gt; { lbl28, lbl33, lbl37, lbl42, lbl47 };
            lst22 = new List&lt;Label&gt; { lbl29, lbl34, lbl38, lbl43, lbl48 };
            lst23 = new List&lt;Label&gt; { lbl25, lbl31, lblFree2, lbl42, lbl48 };
            lst24 = new List&lt;Label&gt; { lbl29, lbl33, lblFree2, lbl40, lbl44 };
            lstPlayerOne = new List&lt;List&lt;Label&gt;&gt; { lst1, lst2, lst3, lst4, lst5, lst6, lst7, lst8, lst9, lst10, lst11, lst12 };
            lstPlayerTwo = new List&lt;List&lt;Label&gt;&gt; { lst13, lst14, lst15, lst16, lst17, lst18, lst19, lst20, lst21, lst22, lst23, lst24 };
        }


        private void LabelFill()
        {
            if (optOnePlayer.Checked == true)
            {
                foreach (Label lbl in lst1labels)
                {
                    lbl.Text = rnd.Next(0, 50).ToString();
                    lbl.BackColor = Color.WhiteSmoke;
                }

                foreach (Label lbl in lst2labels)
                {
                    lbl.Text = "";
                    lbl.BackColor = Color.WhiteSmoke;
                }
            }

            if (optTwoPlayer.Checked == true)
            {
                foreach (Label lbl in lstlabels)
                {
                    lbl.Text = rnd.Next(0, 50).ToString();
                    lbl.BackColor = Color.WhiteSmoke;
                }
            }

            return;
        }
        private void DisplayNumber()
        {
            lblDisplayMain.Text = rnd.Next(0, 50).ToString();
        }
        private void CheckMatch()
        {
            foreach (Label lbl in lstlabels)
            {
                if (lblDisplayMain.Text == lbl.Text)
                {
                    lbl.BackColor = Color.Yellow;
                }
            }
        }
        private void SetButtonNextEnabledDisabled(bool EnabledValue)
        {
            { btnNext.Enabled = EnabledValue; }
        }
        private void FreeLabelColor()
        {
            foreach (Label l in lstFrees)
                if (l.BackColor == Color.Red)
                {
                    l.BackColor = Color.Yellow;
                }
        }
        private void OnePlayer()
        {
            foreach (List&lt;Label&gt; lst in lstPlayerOne)
                if (lst.First().BackColor == Color.Yellow & lst.Where(l =&gt; l.BackColor == lst.First().BackColor).Count() == lst.Count())
                {
                    lst.ForEach(b =&gt; b.BackColor = Color.Red);
                    lblDisplayMain.Text = "Blue is the Winner!!";
                    SetButtonNextEnabledDisabled(false);
                }
        }
        private void TwoPlayer()
        {

            {
                foreach (List&lt;Label&gt; lst in lstPlayerTwo)
                    if (lst.First().BackColor == Color.Yellow & lst.Where(l =&gt; l.BackColor == lst.First().BackColor).Count() == lst.Count())

                    {
                        lst.ForEach(b =&gt; b.BackColor = Color.Red);
                        lblDisplayMain.Text = "Green is the Winner!!";
                        SetButtonNextEnabledDisabled(false);
                    }

            }
        }

        private void CheckWinner()
        {
            if (optOnePlayer.Checked == true)
            {
                OnePlayer();
            }
            if (optTwoPlayer.Checked == true)
            {
                OnePlayer();
                TwoPlayer();
            }
        }
        private void EachTurn()
        {
            DisplayNumber();
            CheckMatch();
            CheckWinner();

        }
        private void StartGame()
        {
            LabelFill();
            SetButtonNextEnabledDisabled(true);
        }
        private void BtnNext_Click(object sender, EventArgs e)
        {
            EachTurn();
        }

        private void BtnStart_Click(object sender, EventArgs e)
        {
            StartGame();
            FreeLabelColor();
            lblDisplayMain.Text = "";
        }

    }
'
where vchDevSubSectionCode = 'bingogame'