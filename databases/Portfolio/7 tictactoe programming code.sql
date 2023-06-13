update DevSubSection
set vchProgrammingCode =
'public partial class frmTicTacToe3 : Form
    {
        string currentturn = "X";
        List&lt;Button&gt; lstbuttons = null;
        List&lt;Button&gt; lst1 = null;
        List&lt;Button&gt; lst2 = null;
        List&lt;Button&gt; lst3 = null;
        List&lt;Button&gt; lst4 = null;
        List&lt;Button&gt; lst5 = null;
        List&lt;Button&gt; lst6 = null;
        List&lt;Button&gt; lst7 = null;
        List&lt;Button&gt; lst8 = null;
        List&lt;List&lt;Button&gt;&gt; lstMasterList = null;



        public frmTicTacToe3()
        {
            InitializeComponent();
            SetupGame();

            lstbuttons.ForEach (btn =&gt; btn.Click += ButtonClick) ;
            
            //foreach (Button b in lstbuttons )
            //{
            //    b.Click += ButtonClick;
            //}

            btnStart.Click += BtnStart_Click;

            StartGame();
        }

        private void SetupGame()
        {
            
            lstbuttons = new List&lt;Button&gt; { btn5, btn1, btn3, btn7, btn9, btn2, btn4, btn6, btn8 };
            lst1 = new List&lt;Button&gt; { btn1, btn2, btn3 };
            lst2 = new List&lt;Button&gt; { btn4, btn5, btn6 };
            lst3 = new List&lt;Button&gt; { btn7, btn8, btn9 };
            lst4 = new List&lt;Button&gt; { btn1, btn4, btn7 };
            lst5 = new List&lt;Button&gt; { btn2, btn5, btn8 };
            lst6 = new List&lt;Button&gt; { btn3, btn6, btn9 };
            lst7 = new List&lt;Button&gt; { btn1, btn5, btn9 };
            lst8 = new List&lt;Button&gt; { btn3, btn5, btn7 };
            lstMasterList = new List&lt;List&lt;Button&gt;&gt; {lst1,lst2,lst3,lst4,lst5,lst6,lst7,lst8};
           
        }
        private void StartGame()
        {
            currentturn = "X";
            foreach (Button b in lstbuttons)
            {
                b.Text = "";
                b.BackColor = Color.WhiteSmoke;
            }
            SetButtonsEnabledDisabled(true);
            DisplayTurn();
        }
        private void DisplayTurn()
        {
            lblDisplayWinner.Text = "It is " + currentturn + "''s turn";
        }
        private void SetButtonsEnabledDisabled(bool EnabledValue)
        {
            lstbuttons.ForEach(btn =&gt; btn.Enabled = EnabledValue);
        }

        private bool CheckWinner()
        {
            bool winner = false;
            foreach (List&lt;Button&gt; lst in lstMasterList)
            {
                if (lst.First().Text !="" & lst.Where (btn=&gt; btn.Text == lst.First().Text).Count() == lst.Count())

                {
                    winner = true;

                    lst.ForEach(b =&gt; b.BackColor = Color.Yellow);

                    lblDisplayWinner.Text = lst.First().Text + " Is THE WINNER!!";
                    SetButtonsEnabledDisabled(false);
                }

            }
            return winner;
        }
        private bool CheckTie()
        {
            bool tie = false;
            if (lstbuttons.Where(b =&gt; b.Text != "").Count() == lstbuttons.Count())
            {
                tie = true;
                lblDisplayWinner.Text = "Tie!!!!!!!!! TIE! BETTER LUCK NEXT TIME!";
            }
            return tie;
        }
  
        private bool DoOffenseDefense (string letter = "O")
        {
            bool winner = false;
            foreach (List&lt;Button&gt; lb in lstMasterList)
            {
                Button b1 = lb[0];
                Button b2 = lb[1];
                Button b3 = lb[2];

                if (b1.Text == letter & b2.Text == b1.Text & b3.Text == "")
                {
                    DoTurn(b3);
                    winner = true;
                    break;
                }
                else if (b1.Text == letter & b3.Text == b1.Text & b2.Text == "")
                {
                    DoTurn(b2);
                    winner = true;
                    break;
                }
                else if (b2.Text == letter & b3.Text == b2.Text & b1.Text == "")
                {
                    DoTurn(b1);
                    winner = true;
                    break;
                }
            }
            return winner;
        }

        private bool DoComputerTurn()
        {
            bool winner = false;
            //offense
            winner = DoOffenseDefense();
            if (winner == true) { return winner; }

            //defense
            winner = DoOffenseDefense("X");
            if (winner == true) { return winner; }

            //pick the best possible button
            foreach (Button b in lstbuttons)
            {
                if (b.Text == "")
                {
                    DoTurn(b);
                    break;
                }
            }
            return winner;
        }
        private void DoTurn(object sender)
        {
            Button btn = (Button)sender;
            bool gameover = false;
            if (btn.Text == "")
            {

                btn.Text = currentturn;
                gameover = CheckWinner();
                if (gameover == true) 
                {
                    return;
                }
                gameover = CheckTie();
                if (gameover == true)
                {
                    return;
                }

                if (currentturn == "X")
                {
                    currentturn = "O";
                }
                else
                {
                    currentturn = "X";
                }
                if (optPlayAgainstComputer.Checked == true & currentturn == "O")
                {
                    gameover = DoComputerTurn();
                    if (gameover == true)
                    {
                        return;
                    }
                }

                DisplayTurn();
            }
        }
        private void BtnStart_Click(object sender, EventArgs e)
        {
            StartGame();
        }
        private void ButtonClick(object sender, EventArgs e)
        {
            DoTurn(sender);
        }

    }
	'
	where vchDevSubSectionCode = 'tictactoe'