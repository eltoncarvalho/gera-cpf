#INCLUDE "protheus.ch"
#Include "Colors.ch"
#Include "comxfun2.ch"
#include "RwMake.ch"

 
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PREPRECO     º Autor ³ JORGE OLIVEIRA     º Data ³  22/08/12º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Precificação de Preço Venda                                º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function PEPRECO()


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Declaracao de Variaveis                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


	Private cCadastro := "Precificação de Preço"
	Private aCORES  := {}
	Private oOk  := LoadBitMap(GetResources(), "LBOK")
	Private oNo  := LoadBitMap(GetResources(), "LBNO")
	Private oVerde := LoadBitmap(GetResources(),'br_verde')
	Private oVerme := LoadBitmap(GetResources(),'br_vermelho')
	Private oAmar := LoadBitmap(GetResources(),'br_amarelo')
	Private oBranc := LoadBitmap(GetResources(),'br_branco')
	Private oPret := LoadBitmap(GetResources(),'BR_PRETO')
	Private lMantPr := .f.

	aCORES  :=  {;
	{"SZ2->Z2_FLAG = SPACE(2)","BR_VERDE"  },;     //Produto Não Precificado
	{"SZ2->Z2_FLAG <> SPACE(2)","BR_VERMELHO" }}   //Produto Ja Precificado



	Private Vf:="  "


	Private aRotina := { {"&Legenda","U_LegPre",0,1},;
	{"Visualizar","U_ViEspp",0,2} ,;
	{"Cancelamento","U_CaEspp",0,2} ,;
	{"Inclusão","U_IncEspp",0,3}}


	Private cString := "SZ2"



	dbSelectArea(cString)
	dbSetOrder(1)
	dbgotop()

	mBrowse( 6,1,22,75,cString,,,,,,aCores,,,,)

	Set Key 123 To // Desativa a tecla F12 do acionamento dos parametros


Return


//// Rotina das Notas


User Function IncEspp()
	// Variaveis Locais da Funcao
	Local cMenucMenu := FWGetMnuFile()

	//Local cMenucMenu := FWGetMnuFile()
	Private cNota := SPACE(9)
	Private cFornece := SPACE(6)
	Private cSerie  := SPACE(3)
	Private cLoja   := SPACE(2)
	Private cFreteEX  := 0
	Private oFreteEX  := 0
	Private cEmissao
	Private cFrete  :=0
	Private oFrete := 0
	Private cDescar:= 0          // Descarga
	Private cSegCar:= 0          // Seguro de Carga
	Private cOuCust:= 0          // Outros Custos
	Private oOuCust
	Private cDesPed
	Private cPedOBS
	Private cVlrBrut
	Private cPedido
	Private cVTotal
	Private cUTotal
	Private cVquant
	Private cPreSug
	Private cMarEst2
	Private oMarEst2
	Private cMarEst        //Margem Estipulada
	Private cMarMin        //Margem Minima
	Private cMarMax        //Margem Maxima
	Private cEst
	Private cGrTrib
	Private cPPisC
	Private cPPisD
	Private cPCONFD
	Private cPCONFC
	Private cICMST
	Private cICMVST
	Private cVAtac
	Private cVAvar
	Private cAicmD
	Private cPrefixo := SPACE(3)
	Private cNumTit:= SPACE(9)
	Private cForDesc := SPACE(6)
	Private cLoDes := SPACE(2)
	Private cVdescR := 0
	Private cICMTRI
	Private cCOFINS
	Private cPIS
	Private cPerV
	Private cPISV := 0
	Private cCOFINSV := 0
	Private cICMtriV := 0
	Private cCuFinalV := 0
	Private cMarEst2V := 0
	Private cVenLV := 0
	Private cPrTran := 0
	Private cVpref := .f.
	Private cVlrBoni := 0
	Private cVlrBoA := 0
	Private cCGC8
	Private cVboni :=  0
	Private cVboniA := 0
	Private cVdescA := 0
	Private cVenLAN
	Private cVdesc:=0
	Private cCuRepo3  := 0
	Private cPISP3  := 0
	Private cCOFINSP3 := 0
	Private cICMtriP3 := 0
	Private cCuFinalP3 := 0
	Private cMarEst2P3 := 0
	Private cVenPR3 := 0
	Private cVAPR3 := 0
	Private vMarPr3 := 0
	// Variaveis Private da Funcao
	Private _oDlg				// Dialog Principal
	Private _oDlgN
	// Variaveis que definem a Acao do Formulario
	Private VISUAL := .F.
	Private INCLUI := .F.
	Private ALTERA := .F.
	Private DELETA := .F.
	// Privates das ListBoxes
	Private aListBox1 := {}
	Private aListBox2 := {}
	Private oListBox1
	Private oListBox2
	Private _aNota:= {}
	Private cCusAnt
	Private cCusAnR
	Private cCusAnF
	Private lSim	 := .F.
	Private lSimDe   := .F.
	Private oSimDe
	Private lSimOd   := .F.
	Private oSimOd
	Private oSim
	Private lBoni:= .F. // FLAG PARA CONTROLAR BONIFICACAO, CAMPO RATEADO QUANDO JA FOI PRECIFICADO
	Private lDesc:= .F. // FLAG PARA CONTROLAR DESCONTO, CAMPO RATEADO QUANDO JA FOI PRECIFICADO
	Private lOdes:= .F. // FLAG PARA CONTROLAR OUTRAS DESPESAS, CAMPO RATEADO QUANDO JA FOI PRECIFICADO
	Private cVboniR := 0
	Private cVbonSa := 0
	Private cVdesU  := 0
	Private cVdescAC :=0
	Private cDDesU   := 0
	Private cEstoq1
	Private cCuMedia
	Private cVqmedia
	Private cCalM1
	Private cCalM2
	Private cCuRepo2
	Private cRepos2
	Private cOutDesp
	Private cOutDsAN
	Private cOutDsUs:= 0
	Private cOutDECo:= 0
	Private cOuDavu := 0    // Variavel para despesas avulsas exemplo: PING e Vasilhame
	Private nVlrPed := 0
	Private cIndTrP3 := 0
	Private cIndTrV := 0
	Private cIndTrA := 0
	Private nIdTra := 0
	Private cCrdPre := 0
	Private nPerManPr := 0
	Private cSuMk3:= 0
	Private cSuPr3:= 0
	Private cSuPrVa:= 0
	Private cSuMkVa:= 0
	Private cSuMkAt:= 0
	Private cSuPrAt:= 0
	Private cRenMed:= 0
	Private cBloque:= ""
	Private nQtdAt:= 0
	Private nQtdPr:= 0
	Private cIdUsuario := retcodusr()
	Private lGerent := .f.
	Private cReviso :=''
	Private oReviso
	Private oVenLV
	Private oVenLiq
	Private oVenPR3
	Private oQtdAt
	Private cBgAtec:= "QLineEdit{ color: #ffffff; border: 1px solid #c5c9ca; background-color: #c36666;}"
	Private cBgNorm:= "QLineEdit{ color: #000000; border: 1px solid #c5c9ca; background-color: #ffffff;}"
	Private lVisuali:= .f.
	Private cCuMedAn := 0
	Private cContAnt := 0
	Private cCustD1 := 0
	Private cQtdD1	 := 0
	Private cFamDes := ''
	cValGer:= GETMV("MV_PRICEGER")

	If cIdUsuario $ cValGer
		lGerent := .t.
	EndIf

	Aadd(aListBox2,{"       ","                           ","            ","          "})


	// Procura nota sem preficacao

	_cQry:=" SELECT F1_DOC "
	_cQry+="      ,F1_SERIE"
	_cQry+=" 	  ,F1_FORNECE"
	_cQry+=" 	  ,F1_LOJA"
	_cQry+=" 	  ,F1_DTDIGIT"
	_cQry+=" 	  ,A2_NOME"
	_cQry+=" 	  ,F1_VALMERC"
	_cQry+="	  ,(SELECT COUNT(Z2_FILIAL)"
	_cQry+="		  FROM SZ2010"
	_cQry+="		  WHERE Z2_FILIAL = F1_FILIAL"
	_cQry+="		  AND   Z2_DOC   = F1_DOC"
	_cQry+="		  AND   Z2_SERIE = F1_SERIE"
	_cQry+="		  AND   Z2_FORNECE = F1_FORNECE"
	_cQry+="		  AND   SZ2010.D_E_L_E_T_ = ''"
	_cQry+="		  AND   Z2_FLAG = 'BL') AS BLQ"
	_cQry+=" 	  ,COALESCE((SELECT TOP 1 ZX_ORD"
	_cQry+=" 				  FROM SD1010"
	_cQry+=" 				  LEFT OUTER JOIN SZX010 ON(D1_FILIAL = ZX_FILIAL"
	_cQry+=" 										AND D1_COD    = ZX_COD
	_cQry+=" 										AND '1'       = ZX_PERIODO
	_cQry+=" 										AND ''        = SZX010.D_E_L_E_T_)"
	_cQry+=" 				  WHERE D1_FILIAL = F1_FILIAL"
	_cQry+=" 				  AND   D1_DOC = F1_DOC		"
	_cQry+=" 			  	  AND   D1_SERIE = F1_SERIE"
	_cQry+=" 				  AND   D1_FORNECE = F1_FORNECE"
	_cQry+=" 				  AND   SD1010.D_E_L_E_T_ = ''"
	_cQry+=" 		          ORDER BY ZX_ORD),99999) AS ORD"
	_cQry+=" 	  ,COALESCE((SELECT TOP 1 ZX_ABC"
	_cQry+=" 				  FROM SD1010"
	_cQry+=" 				  LEFT OUTER JOIN SZX010 ON(D1_FILIAL = ZX_FILIAL"
	_cQry+=" 										AND D1_COD    = ZX_COD"
	_cQry+=" 										AND '1'       = ZX_PERIODO "
	_cQry+=" 										AND ''        = SZX010.D_E_L_E_T_)"
	_cQry+=" 				  WHERE D1_FILIAL = F1_FILIAL"
	_cQry+=" 				  AND   D1_DOC = F1_DOC		"
	_cQry+=" 			  	  AND   D1_SERIE = F1_SERIE"
	_cQry+=" 				  AND   D1_FORNECE = F1_FORNECE"
	_cQry+=" 				  AND   SD1010.D_E_L_E_T_ = ''"
	_cQry+=" 		          ORDER BY ZX_ORD),'D') AS ABC "
	_cQry+=" 	   ,F1_EMISSAO"
	_cQry+=" 	   ,F1_EST  "
	_cQry+=" FROM SF1010"
	_cQry+=" LEFT OUTER JOIN SA2010 ON(A2_COD = F1_FORNECE"
	_cQry+=" 					  AND SA2010.D_E_L_E_T_ = '' )"
	_cQry+=" WHERE F1_FILIAL = '"+xFilial("SF1")+"'"
	_cQry+=" AND   F1_PREFIC = ''"
	_cQry+=" AND   F1_ESPECIE IN ('SPED','NFE','NFA')"
	_cQry+=" AND   SF1010.D_E_L_E_T_ = ''"
	_cQry+=" AND   F1_STATUS = 'A'"
	_cQry+=" AND   F1_TIPO NOT IN ('D','I')"
	_cQry+=" AND   F1_COND <> ''"
	_cQry+=" AND   (SELECT COUNT(D1_COD)"
	_cQry+="		FROM SD1010"
	_cQry+="		WHERE D1_FILIAL = F1_FILIAL"
	_cQry+="		AND   D1_DOC = F1_DOC"
	_cQry+="		AND   D1_SERIE = F1_SERIE"
	_cQry+="		AND   D1_FORNECE = F1_FORNECE"
	_cQry+="		AND   SD1010.D_E_L_E_T_ = ''"
	_cQry+="		AND    D1_CF IN('1102','2102','2152','1152')) >= 1"
	_cQry+=" ORDER BY 9,8,5"
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQry),"TMP",.T.,.T.)



	//dbSelectArea("SF1")
	//DbOrderNickName("SF1PREFIC")
	//Dbseek(xFilial("SF1")+" ")

	nsai:= .f.
	dbSelectArea("TMP")
	dbGoTop()
	DO While !TMP->(Eof())
		//IF FOUND()
		//	DO WHILE SF1->F1_FILIAL = xFilial("SF1") .AND. SF1->F1_PREFIC =" "  .AND.  !SF1->(Eof())
		/*
		IF (SF1->F1_ESPECIE = "SPED" .OR. SF1->F1_ESPECIE = "NFE") .AND. SF1->F1_TIPO <> "D" .AND. SF1->F1_STATUS = "A" .AND. SF1->F1_COND <> " "
		else
		SF1->(DbSkip())
		LOOP
		ENDIF
		dbSelectArea("SD1")
		dbSetOrder(1)
		Dbseek(XFILIAL("SD1")+SF1->F1_DOC+SF1->F1_SERIE+SF1->F1_FORNECE+SF1->F1_LOJA)
		IF SD1->D1_CF= "1102" .or. SD1->D1_CF= "2102" .or. SD1->D1_CF= "1152" .or. SD1->D1_CF= "2152"
		ELSE
		dbSelectArea("SF1")
		SF1->(DbSkip())
		LOOP
		ENDIF
		dbSelectArea("SF1")
		*/
		nsai:= .t.
		aadd(_aNota,{' ',IIF(TMP->BLQ > 0,'X',TMP->ABC),TMP->F1_DOC,TMP->F1_SERIE,TMP->F1_FORNECE,TMP->F1_LOJA,STOD(TMP->F1_EMISSAO),STOD(TMP->F1_DTDIGIT),TMP->A2_NOME,TMP->F1_EST,TRANSFORM(TMP->F1_VALMERC,"@E 999,999.99")})
		TMP->(DbSkip())
		//ELSE
		//	TMP->(DbCloseArea())
		//	MsgInfo("Nenhuma Nota Fiscal registrada ")
		//	return .f.
		//ENDIF
	ENDDO
	TMP->(DbCloseArea())
	if nsai = .f.
		MsgInfo("Nenhuma Nota Fiscal registrada ")
		return .f.
	endif



	DEFINE MSDIALOG _oDlgN TITLE OemToAnsi("Escolha as Notas Fiscal      ") FROM C(0),C(0) To C(400),C(700) PIXEL OF oMainWnd //17
	oFont  := TFont():New("Courier New",0,14,,.f.,,,,.f.,.f.)

	_oNota := TWBrowse():New( c(10),c(5),c(340),c(175),,{" ",'',"Nota","Serie","Fornecedor","Loja","Emissao","DT Entrada","Nome","UF","Valor" },{10,10,20,20,20,20,20,20,160,20,40},_oDlgN,,,,,,,,,,,,.F.,,.T.,,.F.,,,)

	_oNota:SetArray(_aNota)
	_oNota:bLine := {|| { iif(_aNota[_oNota:nAt,1]="*",oOk,oNo), iif(_aNota[_oNota:nAt,2]="X",oPret,iif(_aNota[_oNota:nAt,2]="A",oVerme,iif(_aNota[_oNota:nAt,2]="B",oAmar,oVerde))) ,_aNota[_oNota:nAt,3],_aNota[_oNota:nAt,4],_aNota[_oNota:nAt,5],_aNota[_oNota:nAt,6],_aNota[_oNota:nAt,7],_aNota[_oNota:nAt,8],_aNota[_oNota:nAt,9],_aNota[_oNota:nAt,10],_aNota[_oNota:nAt,11]}}

	_oNota:bLDBLCLICK := {|| _aNota[_oNota:nAt,1] := IIF(_aNota[_oNota:nAt,1] = '*',' ','*'), _oNota:refresh() }

	_lOk := .f.

	@ C(188),C(270) Button "Confirma as Notas"           Size C(80),C(10) Action _oDlgN:End() pixel of _oDlgN
	@ C(188),C(002) Button "Legenda"           Size C(40),C(10) Action Legpre() pixel of _oDlgN


	Activate Dialog _oDlgN CENTERED


	nCnot:= 0

	for _nI := 1 to len(_aNota)
		if _aNota[_nI,1] = '*'
			nCnot++
			cNota := _aNota[_nI,3]
			cFornece := _aNota[_nI,5]
			cSerie  := _aNota[_nI,4]
			cLoja   := _aNota[_nI,6]
			cEmissao :=_aNota[_nI,7]
		endif
	next


	IF nCnot = 0
		MsgInfo("Nenhuma Nota selecionado")
		return .f.
	ENDIF


	IF nCnot > 1
		MsgInfo("Selecione Apenas Uma Nota")
		return .f.
	ENDIF


	// fim

	cPedOBS  := POSICIONE("SF1",1,xFilial("SF1")+cNota+cSerie+cFornece+cLoja,"F1_PEDIDO")

	cOutDesp := POSICIONE("SF1",1,xFilial("SF1")+cNota+cSerie+cFornece+cLoja,"F1_DESPESA")
	cOutDsAN := cOutDesp

	dbselectarea("SZL")
	dbsetorder(1)
	dbseek(xFilial("SF1")+cPedOBS)
	IF FOUND()
		cDesPed:= SZL->ZL_OBSERV
	ELSE
		cDesPed:= SPACE(50)
	ENDIF

	// Função para mostra a observação do pedido
	FaObs(cDesPed)

	IF cOutDesp=0
		FouDesA()
	ENDIF


	lSai:= .F.
	lRec:= .F.
	DEFINE MSDIALOG _oDlg TITLE "Precificação de Produto" FROM C(00),C(174) TO C(450),C(960) PIXEL

	@ C(003),C(002) TO C(035),C(380) LABEL "" PIXEL OF _oDlg

	@ C(008),C(007)  Say "Fornecedor" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
	@ C(008),C(050)  Say "Loja" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
	@ C(008),C(080)  Say "Nota Fiscal" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
	@ C(008),C(118)  Say "Serie" Size C(023),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
	@ C(008),C(157)  Say "Frete" Size C(030),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
	@ C(008),C(202)  Say "Descarga" Size C(030),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
	@ C(008),C(247)  Say "Seguro carga" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
	@ C(008),C(292)  Say "Outros Custos" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
	@ C(008),C(337)  Say "Frete Extra" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF _oDlg

	@ C(018),C(007) MsGet cFornece F3 "SA2"   Size C(030),C(009) COLOR CLR_BLACK PIXEL OF _oDlg  WHEN cFornece = SPACE(6)
	@ C(018),C(050) MsGet cLoja     Size C(015),C(009) COLOR CLR_BLACK PIXEL OF _oDlg WHEN cFornece = SPACE(6)
	@ C(018),C(080) MsGet cNota PICTURE "@!" Size C(025),C(009) COLOR CLR_BLACK PIXEL OF _oDlg WHEN cFornece = SPACE(6)
	@ C(018),C(118) MsGet cSerie Size C(015),C(009) COLOR CLR_BLACK PIXEL OF _oDlg  WHEN cFornece = SPACE(6)


	@ C(018),C(157) MsGet oFrete VAR cFrete PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF _oDlg WHEN cFornece = SPACE(6)
	@ C(018),C(202) MsGet cDescar PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF _oDlg Valid FbuDes() WHEN  cFornece = SPACE(6)
	@ C(018),C(247) MsGet cSegcar PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF _oDlg WHEN cFornece = SPACE(6)
	@ C(018),C(292) MsGet cOuCust PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF _oDlg Valid FbuOutc() WHEN cFornece = SPACE(6)
	@ C(018),C(337) MsGet oFreteEX VAR cFreteEX PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF _oDlg WHEN cFornece = SPACE(6)


	fListBox2()
	Vnota(cNota,cSerie,cFornece,cLoja)

	// Bonificação
	@ C(041),C(285) TO C(075),C(380) LABEL "" PIXEL OF _oDlg
	@ C(045),C(292)  Say "Valor Bonificado" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
	@ C(045),C(337)  Say "Bonificação" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
	@ C(050),C(292) MsGet cVboniR PICTURE "@E 999,999.9999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF _oDlg Valid fdbonG(cVboniR) WHEN cVlrBoni <> 0 .AND. lBoni = .F.
	@ C(050),C(337) MsGet cVlrBoni PICTURE "@E 999,999.9999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF _oDlg WHEN cFornece = SPACE(6)
	@ C(065),C(292) CheckBox oSim Var lSim Prompt "Ratea Valor" Size C(048),C(008) PIXEL OF _oDlg WHEN cVboniR<>0 .AND. lBoni = .F.


	// Desconto
	@ C(080),C(285) TO C(114),C(380) LABEL "" PIXEL OF _oDlg
	@ C(084),C(292) Say "Valor Desconto" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
	// Outras despesas
	@ C(084),C(337)  Say "Outras Despesas" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF _oDlg
	@ C(089),C(292) MsGet cVdesc PICTURE "@E 999,999.9999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF _oDlg WHEN cFornece = SPACE(6)
	@ C(089),C(337) MsGet cOutDesp PICTURE "@E 999,999.9999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF _oDlg WHEN cFornece = SPACE(6)
	@ C(104),C(292) CheckBox oSimDe Var lSimDe Prompt "Ratea Valor" Size C(048),C(008) PIXEL OF _oDlg WHEN cVdesc<>0 .AND. lDesc = .F.
	@ C(104),C(337) CheckBox oSimOd Var lSimOd Prompt "Ratea Valor" Size C(048),C(008) PIXEL OF _oDlg WHEN cOutDesp<>0 .AND.  lOdes = .F.


	@ C(122),C(318) Button "Produto" Size C(037),C(012) PIXEL OF _oDlg Action MsDocument( "SF1", SF1->( Recno() ), 1 )
	@ C(136),C(318) Button "Divergencia Ped." Size C(037),C(012) PIXEL OF _oDlg Action (U_DESPNOT(),lSai:= .f.)

	@ C(210),C(024) Button "Confirma" Size C(037),C(012) PIXEL OF _oDlg Action(_oDlg:END(),lSai:=.T.)
	@ C(210),C(070) Button "Sair" Size C(037),C(012) PIXEL OF _oDlg Action _oDlg:END()
	@ C(210),C(116) Button "Observação do Pedido" Size C(090),C(012) PIXEL OF _oDlg Action FaObs(cDesPed)
	@ C(210),C(218) Button "Automatica" Size C(045),C(012) PIXEL OF _oDlg  Action finicia(cVboniR,lSimDe,cVdesc,cOutDesp)
	@ C(210),C(340) Button "Legenda"           Size C(40),C(10) pixel of _oDlg Action u_Legpreite()

	//@ C(90),C(0120) Button "$" Size C(010),C(012) PIXEL OF _oDlg Action _oDlg:END()



	ACTIVATE MSDIALOG _oDlg CENTERED


	IF lSai

		if INT(cVlrBoA) <> 0
			ALERT("Existe Saldo de Bonificação, Você Precisa Zerar")
			return
		endif


		if INT(cOutDsAN) <> 0
			ALERT("Existe Saldo de Despesas, Você Precisa Zerar")
			return
		endif


		IF round(cVdesc,2) <> 0
			if !lSimDe
				IF int(cVdescA) <> 0
					ALERT("Existe Saldo de Desconto, Você Precisa Zerar")
					return
				ENDIF
			endif
		ENDIF



		dbSelectArea("SZ2")
		dbSetOrder(1)
		Dbseek(xFilial("SB0")+cNota+cSerie+cFornece+cLoja)

		DO WHILE SZ2->Z2_DOC = cNota .AND. SZ2->Z2_SERIE = cSerie .AND. SZ2->Z2_FORNECE = cFornece   .AND. SZ2->Z2_LOJA = cLoja .AND. !SZ2->(Eof())
			if !EMPTY(SZ2->Z2_FORDES)
				cForDesc := SZ2->Z2_FORDES
				cLoDes :=SZ2->Z2_LOJDES
				cPrefixo:=SZ2->Z2_PREFIXO
				cNumTit := SZ2->Z2_NUMTIT
			endif


			IF Z2_FLAG <> 'OK'
				ALERT("Confirmação Invalida Falta Produto para Precificar ")
				RETURN
			ENDIF
			SZ2->(DbSkip())
		ENDDO



		dbSelectArea("SF1")
		dbSetOrder(1)
		Dbseek(xFilial("SF1")+cNota+cSerie+cFornece+cLoja)
		RecLock("SF1",.F.)
		SF1->F1_PREFIC  := "S"
		SF1->(MsUnLock())


		// Atualizando o Campo no Contas a Pagar caso tenha Descarga



		IF cDescar <> 0
			dbSelectArea("SE2")
			dbSetOrder(6)
			Dbseek(xFilial("SE2")+cForDesc+cLoDes+cPrefixo+cNumTit)
			RecLock("SE2",.F.)
			SE2->E2_NOTADES  := cNota
			SE2->(MsUnLock())
		ENDIF

		//// Atualizando o Campo no Contas a Pagar caso tenha outros custos

		IF cOuCust <> 0
			dbSelectArea("SE2")
			dbSetOrder(6)
			Dbseek(xFilial("SE2")+cForDesc+cLoDes+cPrefixo+cNumTit)
			RecLock("SE2",.F.)
			SE2->E2_NOTAOUC  := cNota
			SE2->(MsUnLock())
		ENDIF


	ENDIF

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³fListBox2() ³ Autor ³ Ricardo Mansano       ³ Data ³23/07/2012³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Montagem da ListBox                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fListBox2(nNota,nSerie,nFornec,nLoja)


	aListBox2 := {}

	IF !empty(nNota)
		dbSelectArea("SD1")
		dbSetOrder(1)
		Dbseek(xFilial("SD1")+nNota+nSerie+nFornece+nLoja)
		if !found()
			alert("Nota Inexistente ")
		ENDIF
		DO WHILE SD1->D1_DOC = nNota .AND. SD1->D1_SERIE = nSerie .AND. SD1->D1_FORNECE = nFornec .AND. !SD1->(Eof())
			aadd(aListBox2,{vf,SD1->D1_COD,POSICIONE("SB1",1,xFilial("SB1")+SD1->D1_COD,"B1_DESC"),TRANS(SD1->D1_QUANT,"@E 99999.999"),TRANS(SD1->D1_VUNIT,"@E 9999.99")})
			SD1->(DbSkip())
			nreg++
		ENDDO
	ELSE
		Aadd(aListBox2,{vf,"     ","                          ","            ","            "})
	ENDIF

	@ C(40),C(007) ListBox oListBox2 Fields ;
	HEADER "Status","Produto","Nome","Quantidade","Preco";
	Size C(274),C(168) Of _oDlg Pixel;
	ColSizes 20,50,100,70,70 ON DBLCLICK Fpreco(aListBox2[oListBox2:nAT,02],aListBox2[oListBox2:nAT,03])
	oListBox2:bKeyDown:={|nKey|IF(nKey==VK_RETURN,Fpreco(aListBox2[oListBox2:nAT,02],aListBox2[oListBox2:nAT,03]),nil)}

	oListBox2:Refresh(aListBox2)
	oListBox2:SetArray(aListBox2)


	// Carrege aqui sua array da Listbox


	oListBox2:bLine := {|| {;
	IIF(aListBox2[oListBox2:nAT,01] = 'OK',oVerde,IIF(aListBox2[oListBox2:nAT,01] = 'BL',oVerme,oBranc)),;//aListBox2[oListBox2:nAT,01],;
	aListBox2[oListBox2:nAT,02],;
	aListBox2[oListBox2:nAT,03],;
	aListBox2[oListBox2:nAT,04],;
	aListBox2[oListBox2:nAT,05]}}


Return nil


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³   C()   ³ Autores ³ Norbert/Ernani/Mansano ³ Data ³10/05/2005³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Funcao responsavel por manter o Layout independente da       ³±±
±±³           ³ resolucao horizontal do Monitor do Usuario.                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function C(nTam)
	Local nHRes	:=	oMainWnd:nClientWidth	// Resolucao horizontal do monitor
	If nHRes == 640	// Resolucao 640x480 (soh o Ocean e o Classic aceitam 640)
		nTam *= 0.8
	ElseIf (nHRes == 798).Or.(nHRes == 800)	// Resolucao 800x600
		nTam *= 1
	Else	// Resolucao 1024x768 e acima
		nTam *= 1.28
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Tratamento para tema "Flat"³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If "MP8" $ oApp:cVersion
		If (Alltrim(GetTheme()) == "FLAT") .Or. SetMdiChild()
			nTam *= 0.90
		EndIf
	EndIf
Return Int(nTam)


STATIC FUNCTION fLisP(nNota,nSerie,nFornec,nLoja)

	dbSelectArea("SF1")
	dbSetOrder(1)
	Dbseek(xFilial("SF1")+nNota+nSerie+nFornec+nLoja)
	if !found()
		alert("Nota Não Encontrada")
		return .f.
	ENDIF

	aListBox2 := {}

	dbSelectArea("SZ2")
	dbSetOrder(1)
	Dbseek(xFilial("SB0")+nNota+nSerie+nFornec+nLoja)
	IF !FOUND()
		dbSelectArea("SD1")
		dbSetOrder(1)
		Dbseek(xFilial("SD1")+nNota+nSerie+nFornec+nLoja)

		DO WHILE SD1->D1_DOC = cNota .AND. SD1->D1_SERIE = nSerie .AND. SD1->D1_FORNECE = nFornec  .AND. SD1->D1_LOJA = nLoja .AND. !SD1->(Eof())
			IF D1_CFOP='6910'   // VERIFICA QUE O PRODUTO É BONIFICAÇÃO É NÃO GRAVA NA TABELA
		       SD1->(DbSkip())
		       LOOP
			ENDIF

			cAProduto:= D1_COD
			cAQuant := D1_QUANT
			cAvunit := D1_VUNIT

			dbSelectArea("SZ2")
			dbSetOrder(1)
			RecLock("SZ2",.T.)
			SZ2->Z2_FILIAL := xFilial("SB0")
			SZ2->Z2_DOC := cNota
			SZ2->Z2_SERIE := cSerie
			SZ2->Z2_FORNECE := cFornece
			SZ2->Z2_LOJA := cLoja
			SZ2->Z2_EMISSAO := cEmissao
			SZ2->Z2_PROD   := cAProduto
			SZ2->Z2_QUANT  := cAQuant
			SZ2->Z2_VUNIT  := cAvunit
			SZ2->(MsUnLock())

			dbSelectArea("SD1")

			SD1->(DbSkip())
		ENDDO

	ENDIF

	dbSelectArea("SZ2")
	dbSetOrder(1)
	Dbseek(xFilial("SB0")+nNota+nSerie+nFornec+nLoja)

	DO WHILE SZ2->Z2_DOC = nNota .AND. SZ2->Z2_SERIE = nSerie .AND. SZ2->Z2_FORNECE = nFornec   .AND. SZ2->Z2_LOJA = nLoja .AND. !SZ2->(Eof())
		aadd(aListBox2,{SZ2->Z2_FLAG,SZ2->Z2_PROD,POSICIONE("SB1",1,xFilial("SB1")+SZ2->Z2_PROD,"B1_DESC"),TRANS(SZ2->Z2_QUANT,"@E 9999.999"),TRANS(SZ2->Z2_VUNIT,"@E 99999.99")})
		SZ2->(DbSkip())
	ENDDO


	oListBox2:SetArray(aListBox2)

	oListBox2:bLine := {|| {;
	IIF(aListBox2[oListBox2:nAT,01] = 'OK',oVerde,IIF(aListBox2[oListBox2:nAT,01] = 'BL',oVerme,oBranc)),;//aListBox2[oListBox2:nAT,01],;
	aListBox2[oListBox2:nAT,02],;
	aListBox2[oListBox2:nAT,03],;
	aListBox2[oListBox2:nAT,04],;
	aListBox2[oListBox2:nAT,05]}}


	oListBox2:Refresh()

	SetFocus(cFrete)

RETURN .T.

// Função para o calculo da precificação

STATIC FUNCTION Fpreco(cProd,cNomeP)

	//Private cVquant
	//Private cRepos
	//Private cVLREAL
	//Private _oDlgM
	// Variaveis para alteração caso estejam errados os dados


	Local cEdit2	 := Space(30)
	Local cEdit3	 := Space(30)
	Local cEdit5	 := Space(30)
	Local cEdit6	 := Space(30)

	Private cCuAntF
	Private cVquant
	Private cRepos
	Private cVLREAL
	Private _oDlgM



	dbSelectArea("SB1")
	dbSetOrder(1)
	Dbseek(xFilial("SB1")+cProd)
	cNomeP:= B1_DESC
	cGruAl := B1_GRUPO
	cFamAl := B1_CFAM
	cMarAl := B1_MARCA
	cFabAl := B1_FABR



	cCrdPre:= cICMST1P := POSICIONE("SF4",1,xFilial("SF4")+SB1->B1_TS,"F4_CRDPRES")

	IF EMPTY(cFamAl)
		cEdit2	 := Space(30)
	ELSE
		cEdit2   := POSICIONE("SZ1",1,xFilial("SZ1")+cFamAl,"Z1_DESC")
	ENDIF

	IF EMPTY(cGruAl)
		cEdit3	 := Space(30)
	ELSE
		cEdit3   := POSICIONE("SBM",1,xFilial("SBM")+cGruAl,"BM_DESC")
	ENDIF

	IF EMPTY(cMarAl)
		cEdit5	 := Space(30)
	ELSE
		cEdit5    := POSICIONE("SZ7",1,xFilial("SZ7")+cMarAl,"Z7_DESC")
	ENDIF

	IF EMPTY(cFabAl)
		cEdit6	 := Space(30)
	ELSE
		cEdit6    := POSICIONE("SZ6",1,xFilial("SZ6")+cFabAl,"Z6_DESC")
	ENDIF

	cVisual:= .F.
	lfm:=  .f.
	/*
	DEFINE FONT oFONT4 NAME "ARIAL"  SIZE   0, -15
	DEFINE MSDIALOG _oDlgM TITLE "Informações Analisar" FROM C(267),C(183) TO C(550),C(980) PIXEL

	// Cria Componentes Padroes do Sistema
	@ C(007),C(003) SAY cProd+" "+cNomeP  Size C(0150),C(009) COLOR CLR_BLACK PIXEL OF _oDlgM FONT oFONT4

	@ C(017),C(003) Say "Familia" Size C(018),C(008) COLOR CLR_BLACK PIXEL OF _oDlgM
	@ C(017),C(172) Say "Grupo" Size C(018),C(008) COLOR CLR_BLACK PIXEL OF _oDlgM

	@ C(047),C(003) Say "Marca" Size C(018),C(008) COLOR CLR_BLACK PIXEL OF _oDlgM
	@ C(047),C(172) Say "Fabricante" Size C(030),C(008) COLOR CLR_BLACK PIXEL OF _oDlgM

	@ C(027),C(003) MsGet cFamAl F3 "SZ1"   Size C(020),C(009) COLOR CLR_BLACK PIXEL OF _oDlgM
	@ C(027),C(30) MsGet  cEdit2 Size C(0100),C(009) COLOR CLR_BLACK PIXEL OF _oDlgM WHEN cVisual = .T.
	@ C(027),C(172) MsGet cGruAl F3 "SBM" Size C(020),C(009) COLOR CLR_BLACK PIXEL OF _oDlgM VALID !EMPTY(cGruAl)
	@ C(027),C(197) MsGet cEdit3 Size C(0100),C(009) COLOR CLR_BLACK PIXEL OF _oDlgM WHEN cVisual = .T.

	@ C(057),C(003) MsGet cMarAl F3 "SZ7"   SIZE C(020),C(009) COLOR CLR_BLACK PIXEL OF _oDlgM VALID !EMPTY(cGruAl)
	@ C(057),C(30) MsGet  cEdit5 Size C(0100),C(009) COLOR CLR_BLACK PIXEL OF _oDlgM WHEN cVisual = .T.

	@ C(057),C(172) MsGet cFabAl F3 "SZ6" Size C(020),C(009) COLOR CLR_BLACK PIXEL OF _oDlgM VALID !EMPTY(cGruAl)
	@ C(057),C(201) MsGet cEdit6 Size C(0100),C(009) COLOR CLR_BLACK PIXEL OF _oDlgM WHEN cVisual = .T.

	@ C(100),C(024) Button "Sair" Size C(037),C(012) PIXEL OF _oDlgM action(_oDlgM:END())
	@ C(100),C(075) Button "Confirma" Size C(037),C(012) PIXEL OF _oDlgM action(lfm:= .t.,_oDlgM:END())


	ACTIVATE MSDIALOG _oDlgM CENTERED

	IF lfm = .t.
	dbSelectArea("SB1")
	dbSetOrder(1)
	RecLock("SB1",.F.)
	SB1->B1_GRUPO  :=  cGruAl
	SB1->B1_CFAM   :=  cFamAl
	SB1->B1_MARCA  :=  cMarAl
	SB1->B1_FABR   :=  cFabAl
	SB1->(MsUnLock())
	ENDIF
	*/
	///

	dbSelectArea("SZ2")
	dbSetOrder(1)
	Dbseek(xFilial("SB0")+cNota+cSerie+cFornece+cLoja+cProd)

	IF FOUND()
		cFlag := SZ2->Z2_FLAG
		IF cFlag  = "OK"
			MsgAlert("Item já precificado, para alterar precifição efetue o cancelamento!")
			Return
		EndIf

		// Atualizando as informações caso o item ja esteja precificado
		IF cFlag  = "OK" .OR. cFlag  = "BL"
			// Atualizando o Desconto
			IF SZ2->Z2_VLRDR <> 0
				if !lsimde
					cVdescA := cVdescA + SZ2->Z2_VLRDR
					// Voltando o Produto para o status de sem precificação
					RecLock("SZ2",.F.)
					SZ2->Z2_FLAG  := "  "
					SZ2->(MsUnLock())
				endif
			ENDIF

			// Atualizando a Bonificação
			IF SZ2->Z2_VLRBON <> 0
				cVlrBoA := cVlrBoA + SZ2->Z2_VLRBON

				dbSelectArea("SZB")
				RecLock('SZB',.T.)
				SZB->ZB_FILIAL  := xFilial("SD1")
				SZB->ZB_FORNECE := cFornece
				SZB->ZB_LOJA    := cLoja
				SZB->ZB_NOTA    := cNota
				SZB->ZB_SERIE   := cSerie
				SZB->ZB_VALOR   := SZ2->Z2_VLRBON
				SZB->ZB_DATA    := Date()
				SZB->ZB_TIPO    := "C"
				SZB->ZB_EMISSAO := cEmissao
				SZB->ZB_CGC     := cCGC8
				SZB->ZB_OBSERV  := "CANCEL.PRECIF. DE PRODUTO"
				SZB->ZB_TPMOV   := '1'
				SZB->ZB_ORIG    := 'PRECO'
				SZB->ZB_USUAR   := Alltrim(cUserName)
				SZB->(MsUnlock())

				// Baixa na Bonificacao
				dbSelectArea("SZC")
				dbSetOrder(2)
				dBseek(xFilial("SZC")+cCgc8)

				IF FOUND()
					RecLock('SZC',.F.)
					SZC->ZC_SALDO += SZ2->Z2_VLRBON
					SZC->ZC_ULTDATA := Date()
					SZC->(MsUnlock())
				ENDIF
				// Voltando o Produto para o status de sem precificação
				dbSelectArea("SZ2")
				RecLock("SZ2",.F.)
				SZ2->Z2_FLAG  := "  "
				SZ2->Z2_VLRBON := 0
				SZ2->(MsUnLock())

			ENDIF

		ENDIF
	ENDIF



	dbSelectArea("SD1")
	dbSetOrder(1)
	Dbseek(xFilial("SD1")+cNota+cSerie+cFornece+cLoja+cProd)
	if found()
		lFam:= .F.
		cFamil:= POSICIONE("SB1",1,xFilial("SB1")+cProd,"B1_CFAM")
		DbSelectArea("SZ1")
		DbSetOrder(1)
		DbSeek(xFilial("SZ1")+SB1->B1_CFAM)


		IF cFamil<>SPACE(2) .AND. SZ1->Z1_PADPREC = 'S'
			lFam:= .T.
		EndIf
		cItens:=""
		IF lFam

			// Coloca no array as familia do produto
			Private oDlgfa
			Private oOk  := LoadBitMap(GetResources(), "LBOK")
			Private oNo  := LoadBitMap(GetResources(), "LBNO")
			Private aArFam:= {}
			Private oArFam

			cFamDes:= SZ1->Z1_COD+" - "+SZ1->Z1_DESC

			dbSelectArea("SB1")
			SB1->(DbOrderNickName("FAMILIA"))
			dbseek(xFilial("SB1")+cFamil)
			mSeqf:=0
			DO WHILE SB1->B1_CFAM = cFamil  .AND. !SB1->(Eof())
				aadd(aArFam,{' ',SB1->B1_COD,SB1->B1_DESC,SB1->B1_UM})
				mSeqf++
				dbskip()

			ENDDO

			IF mSeqf = 0
				MsgInfo("Não Existe Produto com Esta Familia")
				return .t.
			ENDIF



			oOk  := LoadBitMap(GetResources(), "LBOK")
			oNo  := LoadBitMap(GetResources(), "LBNO")


			DEFINE MSDIALOG _oDlgfa TITLE OemToAnsi("Escolha os Produtos Referente a Familia") FROM C(0),C(0) To C(200),C(700) PIXEL OF oMainWnd //17
			oFont  := TFont():New("Courier New",0,14,,.f.,,,,.f.,.f.)

			oArFam := TWBrowse():New( c(10),c(5),c(340),c(075),,{" ","Produto","Descrição","Unidade"},,_oDlgfa,,,,,,,,,,,,.F.,,.T.,,.F.,,,)

			oArFam:SetArray(aArFam)
			oArFam:bLine := {|| { iif(aArFam[oArFam:nAt,1]="*",oOk,oNo), aArFam[oArFam:nAt,2] ,aArFam[oArFam:nAt,3],aArFam[oArFam:nAt,4]}}

			oArFam:bLDBLCLICK := {|| aArFam[oArFam:nAt,1] := IIF(aArFam[oArFam:nAt,1] = '*',' ','*'),oArFam:refresh() }

			_lOk := .f.

			@ C(088),C(220) Button "Confirma os Produtos"           Size C(80),C(10) Action  _oDlgfa:End()    pixel of _oDlgfa

			Activate Dialog _oDlgfa CENTERED
			cItens:=""
			For n:=1 To Len(aArFam)
				If aArFam[n,1] = '*'
					If Empty(cItens)
						cItens+= "'"+aArFam[n,2]+"'"
					Else
						cItens+= ",'"+aArFam[n,2]+"'"
					EndIf
				EndIf
			Next

		EndIf
		If Empty(cItens)
			cItens:= "'"+SD1->D1_COD+"'"
		EndIf

		_cQuery:=" SELECT SUM(SD1.D1_TOTAL) AS D1_TOTAL"
		_cQuery+=" 	  ,ROUND(SUM(CAST(SD1.D1_QUANT*SD1.D1_VUNIT AS NUMERIC(12,2)))/SUM(CAST(SD1.D1_QUANT AS NUMERIC(12,2))),2) AS D1_VUNIT"
		_cQuery+=" 	  ,SUM(CAST(SD1.D1_QUANT AS NUMERIC(12,2))) AS D1_QUANT"
		_cQuery+=" 	  ,SUM(CAST(SD1.D1_DESPESA AS NUMERIC(12,2))) AS D1_DESPESA"
		_cQuery+=" 	  ,SUM(CAST(SD1.D1_ICMSRET AS NUMERIC(12,2))) AS D1_ICMSRET"
		_cQuery+=" 	  ,SUM(CAST(SD1.D1_VALDESC AS NUMERIC(12,2))) AS D1_VALDESC"
		_cQuery+=" 	  ,ROUND(SUM(CAST(SD1.D1_VALIPI AS NUMERIC(12,2)))/SUM(SD1.D1_TOTAL)*100,2) AS D1_IPI "
		_cQuery+=" 	  ,COUNT(DISTINCT SD1.D1_TES) AS QTDTES"
		_cQuery+=" 	  ,COUNT(DISTINCT SB1.B1_GRTRIB) AS QTDGR"
		_cQuery+=" FROM SD1010 SD1"
		_cQuery+=" LEFT OUTER JOIN SB1010 SB1 ON(SB1.B1_COD = SD1.D1_COD"
		_cQuery+=" 						  AND SB1.D_E_L_E_T_ = '')"
		_cQuery+=" WHERE SD1.D1_FILIAL = '"+xFilial("SD1")+"'"
		_cQuery+=" AND   SD1.D1_DOC = '"+cNota+"'"
		_cQuery+=" AND   SD1.D1_SERIE = '"+cSerie+"'"
		_cQuery+=" AND   SD1.D1_FORNECE = '"+cFornece+"'"
		_cQuery+=" AND   SD1.D1_COD IN("+cItens+")"
		_cQuery+=" AND   SD1.D1_CFOP <> '6910' "
		_cQuery+=" AND   SD1.D_E_L_E_T_ = ''"
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),"TRB",.T.,.T.)


// foi incluido  na query  _cQuery+=" AND   SD1.D1_CFOP <> '6910'  para não pegar produto que é bonificação 11/09/2017 (jorge)


		If TRB->QTDTES > 1 .OR. TRB->QTDGR > 1
			MsgAlert("Produtos da familia estão configurados com tributação diferente!")
			TRB->(DBCLOSEAREA())
			Return
		EndIf

		If EMPTY(TRB->D1_TOTAL)
			MsgAlert("Arquivo vazio selecione novamente a familia!")
			TRB->(DBCLOSEAREA())
			Return
		EndIf

		cVTotal:= TRB->D1_TOTAL
		cUTotal:= TRB->D1_VUNIT
		cVquant:= TRB->D1_QUANT
		cCustD1 := round(TRB->D1_TOTAL,2)
		cQtdD1 := round(TRB->D1_QUANT,3)
		cPercN:= (cVTotal/cVlrBrut)*100

		if lSimDe =.T.
			cPercD:= (cVdesc/cVlrBrut)*100
		ENDIF
		cTES:= SD1->D1_TES

		IF lSimOd = .T.
			cOutDsUS := TRB->D1_DESPESA
		ELSE
			cOutDsUS := 0
		ENDIF

		cVICMST := TRB->D1_ICMSRET/cVquant
		//cPicmsC:= SD1->D1_PICM
		cPicmsC:= SD1->D1_PICM

		cPPisC:= SD1->D1_ALQPIS  // PIS DE CREDITO
		cPCONFC:= SD1->D1_ALQCOF // CONFIS DE CREDITO


		cTicmST:=.F.


		cICMST1P := POSICIONE("SF4",1,xFilial("SF4")+cTES,"F4_ICM")
		cICMST2P := POSICIONE("SF4",1,xFilial("SF4")+cTES,"F4_CREDICM")
		cICMST3P := POSICIONE("SF4",1,xFilial("SF4")+cTES,"F4_SITTRIB")
		cICMST4P := POSICIONE("SF4",1,xFilial("SF4")+cTES,"F4_ANTICMS")

		IF  cICMST3P ="10"
			cTicmST:= .T.
		ELSE
			IF cICMST3P ="60"
				cTicmST:= .T.
			ENDIF
		ENDIF




		cAicmD:=GETMV("MV_ICMPAD2")

		IF  cICMST3P ="40"
			cAicmD:=0
		ELSE

		ENDIF

		cVAtac:=  POSICIONE("SB0",1,xFilial("SB0")+cProd,"B0_PRV2")
		cVAvar:=  POSICIONE("SB0",1,xFilial("SB0")+cProd,"B0_PRV1")
		cVAPR3:=  POSICIONE("SB0",1,xFilial("SB0")+cProd,"B0_PRV6")
		cPerV :=  POSICIONE("SB0",1,xFilial("SB0")+cProd,"B0_PVENDA")
		vMarPr3:= POSICIONE("SB0",1,xFilial("SB0")+cProd,"B0_MKPPR3")
		cRenMed:= POSICIONE("SB0",1,xFilial("SB0")+cProd,"B0_LUCMCAT")
		nQtdAt := SB0->B0_QTD2
		nQtdPr := SB0->B0_QTDPR3

		cCustoFa2:= TRB->D1_VUNIT
		cCustCont:= TRB->D1_VUNIT-(TRB->D1_VALDESC/TRB->D1_QUANT) // custo contabil utilizado para consumir o cmv  na contabilidade

		if lSimDe =.T.
			IF cVdesc > 0
				cCustoFa2 := cCustoFa2-((cCustoFa2*cPercD)/100)
				cVdescR  := ((cVdesc*cPercD)/100)

			ENDIF
		ENDIF


		cIPI:=(cUTotal*TRB->D1_IPI)/100

		cRdesc := ((cDescar*cPercN)/100)/cVquant
		cRfrete:= (((cFrete+cFreteEX)*cPercN)/100)/cVquant
		cRsegCa:= ((cSegCar*cPercN)/100)/cVquant
		cRoutCus:=((cOuCust*cPercN)/100)/cVquant


		cRBonif:=0

		cICMtri:= (cUTotal*cAicmD)/100

		//cPedido:= SD1->D1_PEDIDO
		cPedido:= SD1->D1_PEDXML

		cPreSug:= 0

		cGrTrib := POSICIONE("SB1",1,xFilial("SB1")+cProd,"B1_GRTRIB")
		cPPisD:= 0
		cPCONFD:= 0

		dbSelectArea("SF7")
		dbSetOrder(3)
		Dbseek(xFilial("SF7")+cGrTrib)
		IF FOUND()

			DO WHILE SF7->F7_FILIAL = xFilial("SF7") .AND. SF7->F7_GRTRIB = cGrTrib .AND. SF7->F7_EST = "**" .AND. SF7->F7_GRPCLI ="CF"


				IF F7_GRPCLI ="CF"
					cPPisD:= SF7->F7_ALIQPIS
					cPCONFD:= SF7->F7_ALIQCOF
					IF cTicmST = .T.
						cICMST := SF7->F7_ALIQEXT
						cPicmsC:= 0
						cAicmD := 0
					ELSE
						cICMST := 0
						//   cPicmsC:= 0
						//   cAicmD := 0
						If SF7->F7_BASEICM > 0
							cAicmD:= ROUND(cAicmD * (SF7->F7_BASEICM / 100),0)
							cPicmsC:= ROUND(cPicmsC * (SF7->F7_BASEICM / 100),0)
						EndIf

					ENDIF
					EXIT
				ELSE
					cPPisD := 0
					cPCONFD:= 0
					cICMST := 0
					cPicmsC:= 0
					cAicmD := 0

				ENDIF

				dbskip()
			ENDDO
		ENDIF



		if cICMST<>0
			cICMVST:=(TRB->D1_VUNIT*cICMST)/100
		else
			cICMVST:=0
		endif


		//  Mudando a Variavel do Custo de Reposição para custo de reposição Médio

		cCuRepo2:= cCustoFa2 + cVICMST + cIPI + cRdesc + cRfrete +cRsegCa +cRoutCus
		cRepos2 := cCuRepo2
		cCustCont:= (cCustCont + cVICMST + cRdesc + cIPI + cRfrete +cRsegCa +cRoutCus)-(cCustCont*(cPicmsC/100))-(cCustCont*(cPPisD/100))-(cCustCont*(cPCONFD/100))

		/*
		cEstoq1  := POSICIONE("SB2",2,xFilial("SB2")+"01"+cProd,"B2_QATU")
		cCuRMed := POSICIONE("SB2",2,xFilial("SB2")+"01"+cProd,"B2_CREPM")
		cCuFMed := POSICIONE("SB2",2,xFilial("SB2")+"01"+cProd,"B2_CFABM")
		cCusCoGr:= POSICIONE("SB2",2,xFilial("SB2")+"01"+cProd,"B2_CCONT")
		*/
		/*
		_cQuery:=" SELECT SUM(SB2.B2_QATU) AS B2_QATU"
		_cQuery+=" 	  ,ROUND(SUM(SB2.B2_CREPM*SB2.B2_QATU)/SUM(SB2.B2_QATU),2) AS B2_CREPM"
		_cQuery+=" 	  ,ROUND(SUM(SB2.B2_CFABM*SB2.B2_QATU)/SUM(SB2.B2_QATU),2) AS B2_CFABM"
		_cQuery+=" 	  ,ROUND(SUM(SB2.B2_CCONT*SB2.B2_QATU)/SUM(SB2.B2_QATU),2) AS B2_CCONT"
		*/
		_cQuery:=" SELECT SUM(SB2.B2_QATU) AS B2_QATU"
		_cQuery+="       ,CASE WHEN SUM(SB2.B2_QATU) =0"
		_cQuery+="             THEN 0"
		_cQuery+=" 	           ELSE ROUND(SUM(SB2.B2_CREPM*SB2.B2_QATU)/SUM(SB2.B2_QATU),2)"
		_cQuery+="        END AS B2_CREPM "
		_cQuery+="       ,CASE WHEN SUM(SB2.B2_QATU) =0"
		_cQuery+="             THEN 0"
		_cQuery+=" 	           ELSE ROUND(SUM(SB2.B2_CFABM*SB2.B2_QATU)/SUM(SB2.B2_QATU),2)"
		_cQuery+="        END AS B2_CFABM "
		_cQuery+="       ,CASE WHEN SUM(SB2.B2_QATU) =0"
		_cQuery+="             THEN 0"
		_cQuery+=" 	           ELSE ROUND(SUM(SB2.B2_CCONT*SB2.B2_QATU)/SUM(SB2.B2_QATU),2)"
		_cQuery+="        END AS B2_CCONT"
		_cQuery+=" FROM SB2010 SB2"
		_cQuery+=" WHERE SB2.B2_FILIAL = '"+xFilial("SD1")+"'"
		_cQuery+=" AND   SB2.B2_COD  IN("+cItens+")"
		_cQuery+=" AND   SB2.B2_LOCAL = '01'"
		_cQuery+=" AND   SB2.D_E_L_E_T_ = ''"
		_cQuery+=" HAVING SUM(SB2.B2_QATU) > 0"
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),"TRC",.T.,.T.)

		cEstoq1 := TRC->B2_QATU
		cCuRMed := TRC->B2_CREPM
		cCuFMed := TRC->B2_CFABM
		cCusCoGr:= TRC->B2_CCONT
		cCuMedAn := TRC->B2_CREPM
		cContAnt := TRC->B2_CCONT

		TRC->(DBCLOSEAREA())

		_cQuery:=" SELECT D1_QUANT "
		_cQuery+=" FROM SD1010"
		_cQuery+=" WHERE D1_FILIAL = '"+SD1->D1_FILIAL+"' "
		_cQuery+=" AND   D1_COD IN("+cItens+")"
		_cQuery+=" AND   SUBSTRING(D1_TES,3,1) = '7' "
		_cQuery+=" AND   D1_DTDIGIT = '"+DTOS(SD1->D1_DTDIGIT)+"' "
		_cQuery+=" AND   D_E_L_E_T_ = ''	"
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),"TMP2",.T.,.T.)

		If Empty(TMP2->D1_QUANT)

		Else
			cEstoq1:= cEstoq1 - TMP2->D1_QUANT
		Endif

		TMP2->(DBCLOSEAREA())

		cVqmedia := cEstoq1 - cVquant

		IF cVqmedia < 0
			cVqmedia := 0
		ENDIF

		If cCuRMed = 0
			cCuRMed := cCuRepo2
			cCuFMed := cCustoFa2
			cVqmedia := cVquant
		EndIf

		cCalRM1 := cCuRMed * cVqmedia
		cCalRM2 := cCuRepo2 * cVquant

		cCalFM1 := cCuFMed * cVqmedia
		cCalFM2 := cCustoFa2 * cVquant

		cCalCM1 := cCusCoGr * cVqmedia
		cCalCM2 := cCustCont * cVquant




		cCuRepo :=  (cCalRM1 +cCalRM2) / (cVqmedia+cVquant)
		cRepos  := cCuRepo

		cCustoFa :=  (cCalFM1+cCalFM2) / (cVqmedia+cVquant)

		cCustCont :=  (cCalCM1+cCalCM2) / (cVqmedia+cVquant)

		/*
		if lSimDe =.T.
		IF cVdesc > 0
		cCustoFa2 := cCustoFa2-((cCustoFa2*cPercD)/100)
		cVdescR  := ((cVdesc*cPercD)/100)
		// cVdescA  := cVdescA - cVdescR
		ENDIF
		ENDIF
		*/

		//

	ELSE
		ALERT("VERIFIQUE")

	endif



	dbSelectArea("SC7")
	dbSetOrder(2)
	Dbseek(xFilial("SC7")+cProd+cFornece+cLoja+cPedido)
	if found()
		cPreSug := SC7->C7_PVENAT
		nVlrPed:= SC7->C7_PRECO
	endif
	cMarEst:= 0        //Margem Estipulada
	cMarMin:= 0        //Margem Minima
	cMarMax:= 0        //Margem Maxima
	vMarPr3:= 0
	// Aguardando Custos Anterior
	cCusAnt := POSICIONE("SB2",1,xFilial("SB2")+cProd+"01","B2_CM1")  // Custo anterior Final
	cCusAnR := POSICIONE("SB2",1,xFilial("SB2")+cProd+"01","B2_CREPOS") // Custo de Reposicao
	cCusAnF := POSICIONE("SB2",1,xFilial("SB2")+cProd+"01","B2_CFAB") // Custo de Fabrica
	cCuAntF := POSICIONE("SB2",2,xFilial("SB2")+"01"+cProd,"B2_CFAB")

	//
	cMarEst:= POSICIONE("SB0",1,xFilial("SB0")+cProd,"B0_MARESP")
	vMarPr3:= POSICIONE("SB0",1,xFilial("SB0")+cProd,"B0_MKPPR3")


	If cPerV = 0
		MsgAlert("Produto com margem VAREJO igual 0!")
		If lGerent = .t.
			TRB->(DBCLOSEAREA())
			Return
		EndIf
	Endif
	If cMarEst = 0
		MsgAlert("Produto com margem ATACADO igual 0!")
		If lGerent = .t.
			TRB->(DBCLOSEAREA())
			Return
		EndIf
	Endif
	If  vMarPr3 = 0
		MsgAlert("Produto com Margem PRECO 3 igual 0!")
		If lGerent = .t.
			TRB->(DBCLOSEAREA())
			Return
		EndIf
	Endif
	/*IF cMarEst = 0
	cGrupo := POSICIONE("SB1",1,xFilial("SB1")+cProd,"B1_GRUPO")
	cMarEst:= POSICIONE("SZE",1,xFilial("SZE")+cGrupo,"ZE_MARESP")
	cMarMin:= POSICIONE("SZE",1,xFilial("SZE")+cGrupo,"ZE_MARMIN")
	cMarMax:= POSICIONE("SZE",1,xFilial("SZE")+cGrupo,"ZE_MARMAX")
	cPerV :=  POSICIONE("SZE",1,xFilial("SZE")+cGrupo,"ZE_PVENDA")
	vMarPr3:= POSICIONE("SZE",1,xFilial("SZE")+cGrupo,"ZE_MPKPR3")

	ELSE
	cMarEst:=POSICIONE("SB0",1,xFilial("SB0")+cProd,"B0_MARESP")
	cMarMin:=POSICIONE("SB0",1,xFilial("SB0")+cProd,"B0_MARMIN")
	cMarMax:=POSICIONE("SB0",1,xFilial("SB0")+cProd,"B0_MARMAX")
	ENDIF
	*/

	cMarEst:=POSICIONE("SB0",1,xFilial("SB0")+cProd,"B0_MARESP")
	cMarMin:=POSICIONE("SB0",1,xFilial("SB0")+cProd,"B0_MARMIN")
	cMarMax:=POSICIONE("SB0",1,xFilial("SB0")+cProd,"B0_MARMAX")

	//cVenLiq := ((cCuFinal*cMarEst)/100)+cCuFinal
	cVenLiq := 0
	cMarEst2:= cMarEst
	cCuFinal := 0

	cICMTRI:=0
	cCOFINS:=0
	cPIS:= 0

	IF cVlrBoA = 0
		cVlrBoA := cVboniR
	ENDIF

	IF lSim
		cVboni:= (cVboniR*cPercN)/100
		cVboniA:= cVboni
	ELSE
		cVboni  := 0
	ENDIF

	lSaiE :=.F.
	cVbonSa := cVlrBoA  // GUARDA O SALDO DA BONIFICAÇÃO PARA RECUPERAR QUANDO NÃO FOR CONFIRMADO
	cVdesU:= 0
	cOutDECo:= cOutDsAN // GUARDA O SALDO DA DESPESA PARA RECUPERAR QUANDO NÃO FOR CONFIRMADO
	//cOutDsUS := 0




	/*
	IF cVdesc > 0
	cCustoFa := cCustoFa-((cCustoFa*cPercD)/100)
	ENDIF
	*/
	If cCrdPre > 0
		cPicmsC  := 0
	EndIf

	If SD1->D1_CLASFIS = '040'
		cPicmsC  := 0
		cAicmD := 0
	EndIf

	cEst:= SF1->F1_EST
	cDescr:= cProd+" "+cNomeP
	cNCM:= SB1->B1_POSIPI
	cTpOper:= SD1->D1_CF+' - '+POSICIONE("SX5",1,SD1->D1_FILIAL+'13'+SD1->D1_CF,"X5_DESCRI")

	// Referencia de percentual maximo de custo mais barato utizado como regra para manter o preco atual
	nPerManPr:= 3 /100

	cMarEst2V:= cPerV


	lMantPr:= .T.
	nIdTra:= 0

	TRB->(DBCLOSEAREA())

	DEFINE MSDIALOG oDlgP TITLE cProd+" "+cNomeP FROM C(10000),C(175) TO C(10350),C(1190) PIXEL

	/*
	@ C(136),C(465) Button "Confirma" Size C(037),C(012) PIXEL OF oDlgP Action(oDlgP:END(),lSaiE:=.T.)

	@ C(066),C(465) Button "Analise Venda" Size C(037),C(012) PIXEL OF oDlgP Action (AnalVen(),lSai:= .f.)
	@ C(080),C(465) Button "Divergencia Ped." Size C(037),C(012) PIXEL OF oDlgP Action (U_DESPNOT(),lSai:= .f.)

	@ C(094),C(465) Button "Atualizar Filial" Size C(037),C(012) PIXEL OF oDlgP Action ATUFILIAL(cProd)
	@ C(108),C(465) Button "Historico" Size C(037),C(012) PIXEL OF oDlgP Action HisPre(cProd)
	@ C(122),C(465) Button "Conhecimento" Size C(037),C(012) PIXEL OF oDlgP Action MsDocument( "SF1", SF1->( Recno() ), 1 )
	@ C(150),C(465) Button "Sair" Size C(037),C(012) PIXEL OF oDlgP Action (lSai:= .f.,oDlgP:END())

	*/

	// Custo Anterior de Fabrica
	@ C(001),C(007) Say "Custo Anterior" Size C(065),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(007),C(007) MsGet cCuAntF  PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0

	@ C(001),C(050) Say "Preço Pedido" Size C(065),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(007),C(050) MsGet nVlrPed  PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0

	@ C(001),C(093) Say "Produto" Size C(121),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(007),C(093) MsGet cDescr  PICTURE "@! " Size C(164),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0

	@ C(001),C(265) Say "Estado" Size C(065),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(007),C(265) MsGet cEst  PICTURE "@!" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0

	@ C(001),C(305) Say "NCM" Size C(065),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(007),C(305) MsGet cNCM  PICTURE "@!" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0

	@ C(001),C(345) Say "Tipo Operacao" Size C(072),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(007),C(345) MsGet cTpOper  PICTURE "@!" Size C(115),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0


	@ C(007),C(468) MsGet nIdTra PICTURE "@E 999,999.9999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgp WHEN cFornece = SPACE(6)

	@ C(018),C(007) Say "Fabrica" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP
	@ C(018),C(050) Say "Fabrica Media" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP

	@ C(018),C(093) Say "ICM ST" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(018),C(136) Say "IPI" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(018),C(179) Say "Descarga" Size C(055),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(018),C(222) Say "Frete" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(018),C(265) Say "Seguro Carga" Size C(055),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(018),C(305) Say "Outros Custos" Size C(055),C(008) COLOR CLR_BLACK PIXEL OF oDlgP




	@ C(037),C(093) Say "Familia" Size C(121),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(043),C(093) MsGet cFamDes  PICTURE "@! " Size C(164),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0

	@ C(037),C(265) Say "Quantidade" Size C(065),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(043),C(265) MsGet cQtdD1  PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0

	@ C(037),C(305) Say "Valor Total" Size C(065),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(043),C(305) MsGet cCustD1  PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0

	//@ C(008),C(320) TO C(065),C(380) LABEL "" PIXEL OF oDlgp

	//@ C(008),C(345)  Say "Valor Bonificado" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oDlgp
	//@ C(008),C(385)  Say "Bonificação" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oDlgp

	@ C(018),C(345)  Say "Desconto Usado" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oDlgp
	@ C(018),C(385)  Say "Desconto Total" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oDlgp

	@ C(018),C(425)  Say "Valor Bonificado" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oDlgp
	@ C(018),C(468)  Say "Bonificação" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oDlgp
	@ C(001),C(468)  Say "% Cust Transf" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oDlgp



	@ C(037),C(342)  Say "Qtd Min Atac" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oDlgp
	@ C(037),C(382)  Say "Qtd Min Preço 3" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oDlgp

	// Outras Despesas
	@ C(037),C(425)  Say "Valor Despesas" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oDlgp
	@ C(037),C(468)  Say "Outras Despesas" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oDlgp


	//

	@ C(025),C(007) MsGet cCustoFa2 PICTURE "@E 999,999.99" Size C(035),C(009) COLOR  CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(025),C(050) MsGet cCustoFa PICTURE "@E 999,999.99" Size C(035),C(009) COLOR  CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(025),C(093) MsGet cVICMST PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(025),C(136) MsGet cIPI PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(025),C(179) MsGet cRdesc PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(025),C(222) MsGet cRfrete PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(025),C(265) MsGet cRsegCa PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(025),C(305) MsGet cRoutCus PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0

	//@ C(018),C(320) MsGet cVboni PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgp valid fdboni(cVboni)  WHEN cVlrBoni <> 0
	//@ C(018),C(373) MsGet cVlrBoA PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgp WHEN cFornece = SPACE(6)

	@ C(025),C(345) MsGet cVdesU PICTURE  "@E 999,999.9999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgp valid (CalDe(cVdesU,cProd) ,Vmargem(cMarEst2,cMarMin,cMarMax,cMarEst,cCustoFa,cCustoFa+cRfrete,cPPisC,cPCONFC,cPicmsC,cAicmD,cCuRepo,cPPisD,cPCONFD,vMarPr3,.f.))   WHEN lSimDe = .f.  .AND. cVdescAC>0
	@ C(025),C(385) MsGet cVdescA PICTURE "@E 999,999.9999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgp WHEN cFornece = SPACE(6)


	@ C(025),C(425) MsGet cVboni PICTURE "@E 999,999.9999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgp   valid (fdboni(cVboni,cprod),Vmargem(cMarEst2,cMarMin,cMarMax,cMarEst,cCustoFa,cCustoFa+cRfrete,cPPisC,cPCONFC,cPicmsC,cAicmD,cCuRepo,cPPisD,cPCONFD,vMarPr3,.f.))  WHEN cVlrBoA <> 0
	@ C(025),C(468) MsGet cVlrBoA PICTURE "@E 999,999.9999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgp WHEN cFornece = SPACE(6)



	@ C(043),C(342) MsGet oQtdAt var nQtdAt PICTURE "@E 999,999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgp when lGerent = .t. valid (lMantPr := .f.,Vmargem(cMarEst2,cMarMin,cMarMax,cMarEst,cCustoFa,cCustoFa+cRfrete,cPPisC,cPCONFC,cPicmsC,cAicmD,cCuRepo,cPPisD,cPCONFD,vMarPr3,.f.))
	@ C(043),C(382) MsGet nQtdPr PICTURE "@E 999,999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgp when lGerent = .t. valid (lMantPr := .f.,Vmargem(cMarEst2,cMarMin,cMarMax,cMarEst,cCustoFa,cCustoFa+cRfrete,cPPisC,cPCONFC,cPicmsC,cAicmD,cCuRepo,cPPisD,cPCONFD,vMarPr3,.f.))

	// Outras Despesas
	@ C(043),C(425) MsGet cOutDsUS PICTURE "@E 999,999.9999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgp valid (CalouDe(cOutDsUS,cProd), Vmargem(cMarEst2,cMarMin,cMarMax,cMarEst,cCustoFa,cCustoFa+cRfrete,cPPisC,cPCONFC,cPicmsC,cAicmD,cCuRepo,cPPisD,cPCONFD,vMarPr3,.f.))    WHEN cOutDsAN>0   //.AND. lSimOd = .f.
	@ C(043),C(468) MsGet cOutDsAN PICTURE "@E 999,999.9999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgp WHEN cFornece = SPACE(6)


	//


	IF cPreSug <> 0
		cVenLiq := cPreSug
		VpreV(cMarEst2,cMarMin,cMarMax,cMarEst,cCustoFa,cCustoFa+cRfrete,cPPisC,cPCONFC,cICMST,cAicmD,cCuRepo,cPPisD,cPCONFD,cVenLiq)
	ENDIF


	@ C(037),C(007) Say "Reposição" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP
	@ C(043),C(007) MsGet cCuRepo2 PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0






	// Preço VAREJO
	@ 069 , 002 GROUP oGroup2 TO 107, 590 PROMPT "Composicao de custos do preço de Varejo" OF oDlgP COLOR 0, 16777215 PIXEL

	@ C(060),C(007) Say "Reposição Médio" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP
	@ C(060),C(050) Say "PIS" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(060),C(093) Say "COFINS" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(060),C(136) Say "ICMS Tributado" Size C(055),C(008) COLOR CLR_BLACK PIXEL OF oDlgP

	@ C(060),C(179) Say "Custo Transfer." Size C(035),C(008) COLOR CLR_RED PIXEL OF oDlgP

	@ C(060),C(222) Say "Custo Final" Size C(025),C(008) COLOR CLR_RED PIXEL OF oDlgP
	@ C(060),C(265) Say "Margem Liquida" Size C(055),C(008) COLOR CLR_BLUE PIXEL OF oDlgP
	@ C(060),C(305) Say "Preço de Varejo" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP

	@ C(060),C(345) Say "Sug MKP Varejo" Size C(065),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(060),C(385) Say "Sug Preço Varejo" Size C(065),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(060),C(425) Say "Tabela Anterior" Size C(065),C(008) COLOR CLR_BLACK PIXEL OF oDlgP

	@ C(067),C(007) MsGet cCuRepo PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(067),C(050) MsGet cPISV PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(067),C(093) MsGet cCOFINSV PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(067),C(136) MsGet cICMtriV PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0

	@ C(067),C(179) MsGet cIndTrV PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0

	@ C(067),C(222) MsGet cCuFinalV PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(067),C(265) MsGet cMarEst2V PICTURE "@E 9,999.99" Size C(035),C(009)  COLOR CLR_BLUE PIXEL OF oDlgP WHEN lGerent = .t. VALID (lMantPr := .f. ,Vmargem(cMarEst2,cMarMin,cMarMax,cMarEst,cCustoFa,cCustoFa+cRfrete,cPPisC,cPCONFC,cPicmsC,cAicmD,cCuRepo,cPPisD,cPCONFD,vMarPr3,.f.))
	@ C(067),C(305)  MsGet oVenLV var cVenLV PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP  WHEN  cCustoFa = 0   &&VALID  VpreV(cMarEst2,cMarMin,cMarMax,cMarEst,cVenLiq)

	@ C(067),C(345) MsGet cSuMkVa PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(067),C(385) MsGet cSuPrVa PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(067),C(425) MsGet cVAvar PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0




	// Preço ATACADO
	@ 108, 002 GROUP oGroup1 TO 146, 590 PROMPT "Composicao de custos do preço de Atacado" OF oDlgP COLOR 0, 16777215 PIXEL

	@ C(090),C(007) Say "Reposição Média" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP
	@ C(090),C(050) Say "PIS" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(090),C(093) Say "COFINS" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(090),C(136) Say "ICMS Tributado" Size C(055),C(008) COLOR CLR_BLACK PIXEL OF oDlgP

	@ C(090),C(179) Say "Custo Transfer." Size C(035),C(008) COLOR CLR_RED PIXEL OF oDlgP

	@ C(090),C(222) Say "Custo Final" Size C(025),C(008) COLOR CLR_RED PIXEL OF oDlgP
	@ C(090),C(265) Say "Margem Liquida" Size C(055),C(008) COLOR CLR_BLUE PIXEL OF oDlgP
	@ C(090),C(305) Say "Preço de Atacado" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP
	@ C(090),C(345) Say "Sug MKP Atac" Size C(065),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(090),C(385) Say "Sug Preço Atac" Size C(065),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(090),C(425) Say "Tabela Anterior" Size C(065),C(008) COLOR CLR_BLACK PIXEL OF oDlgP


	@ C(097),C(007) MsGet cCuRepo PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(097),C(050) MsGet cPIS PICTURE "@E 999,999.9999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(097),C(093) MsGet cCOFINS PICTURE "@E 999,999.9999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(097),C(136) MsGet cICMtri PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0

	@ C(097),C(179) MsGet cIndTrA PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0

	@ C(097),C(222) MsGet cCuFinal PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(097),C(265) MsGet cMarEst2 PICTURE "@E 9,999.99" Size C(035),C(009)  COLOR CLR_BLUE PIXEL OF oDlgP  WHEN lGerent = .t. VALID (lMantPr := .f. ,Vmargem(cMarEst2,cMarMin,cMarMax,cMarEst,cCustoFa,cCustoFa+cRfrete,cPPisC,cPCONFC,cPicmsC,cAicmD,cCuRepo,cPPisD,cPCONFD,vMarPr3,.f.))
	@ C(097),C(305) MsGet oVenLiq var cVenLiq PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP  WHEN cCustoFa = 0
	@ C(097),C(345) MsGet cSuMkAt PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(097),C(385) MsGet cSuPrAt PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(097),C(425) MsGet cVAtac PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0


	// COMPOOSICAO PRECO 3

	@ 147 , 002 GROUP oGroup2 TO 180, 590 PROMPT "Composicao de custos do preço Atacado Volume" OF oDlgP COLOR 0, 16777215 PIXEL

	@ C(120),C(007) Say "Reposição Média" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP
	@ C(120),C(050) Say "PIS" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(120),C(093) Say "COFINS" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(120),C(136) Say "ICMS Tributado" Size C(055),C(008) COLOR CLR_BLACK PIXEL OF oDlgP

	@ C(120),C(179) Say "Custo Transfer." Size C(035),C(008) COLOR CLR_RED PIXEL OF oDlgP
	@ C(120),C(222) Say "Custo Final" Size C(025),C(008) COLOR CLR_RED PIXEL OF oDlgP
	@ C(120),C(265) Say "Margem Liquida" Size C(055),C(008) COLOR CLR_BLUE PIXEL OF oDlgP
	@ C(120),C(305) Say "Preço Atac 3" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP
	@ C(120),C(345) Say "Sug Mkp 3" Size C(065),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(120),C(385) Say "Sug Preço 3" Size C(065),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(120),C(425) Say "Tabela Anterior" Size C(065),C(008) COLOR CLR_BLACK PIXEL OF oDlgP

	@ C(127),C(007) MsGet cCuRepo3 PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(127),C(050) MsGet cPISP3 PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(127),C(093) MsGet cCOFINSP3 PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(127),C(136) MsGet cICMtriP3 PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0

	@ C(127),C(179) MsGet cIndTrP3 PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0

	@ C(127),C(222) MsGet cCuFinalP3 PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(127),C(265) MsGet vMarPr3 PICTURE "@E 9,999.99" Size C(035),C(009)  COLOR CLR_BLUE PIXEL OF oDlgP WHEN lGerent = .t. VALID (lMantPr := .f. ,Vmargem(cMarEst2,cMarMin,cMarMax,cMarEst,cCustoFa,cCustoFa+cRfrete,cPPisC,cPCONFC,cPicmsC,cAicmD,cCuRepo,cPPisD,cPCONFD,vMarPr3,.f.))
	@ C(127),C(305) MsGet oVenPR3 var cVenPR3 PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP  WHEN cCustoFa = 0   &&VALID  VpreV(cMarEst2,cMarMin,cMarMax,cMarEst,cVenLiq)
	@ C(127),C(345) MsGet cSuMk3 PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(127),C(385) MsGet cSuPr3 PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(127),C(425) MsGet cVAPR3 PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0




	Vmargem(cMarEst2,cMarMin,cMarMax,cMarEst,cCustoFa,cCustoFa+cRfrete,cPPisC,cPCONFC,cPicmsC,cAicmD,cCuRepo,cPPisD,cPCONFD,vMarPr3,.f.)



	// Aliquotas

	//@ C(135),C(007) Say "Aliquotas" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP
	@ 182, 002 GROUP oGroup2 TO 220, 390 PROMPT "Aliquotas" OF oDlgP COLOR 0, 16777215 PIXEL
	@ C(148),C(007) Say "PIS Credito" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP
	@ C(148),C(050) Say "COFINS Credito" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP
	@ C(148),C(093) Say "PIS Debito" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP
	@ C(148),C(136) Say "CONFIS Debito" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP
	@ C(148),C(179) Say "ICM Credito" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP
	@ C(148),C(222) Say "ICM Debito" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP
	@ C(148),C(265) Say "ICM Cr Presumido" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP

	@ C(155),C(007) MsGet cPPisC  PICTURE "@E 999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(155),C(050) MsGet cPCONFC  PICTURE "@E 999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(155),C(093) MsGet cPPisD  PICTURE "@E 999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(155),C(136) MsGet cPCONFD PICTURE "@E 999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(155),C(179) MsGet cPicmsC PICTURE "@E 999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(155),C(222) MsGet cAicmD PICTURE "@E 999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(155),C(265) MsGet cCrdPre PICTURE "@E 999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0



	@ C(146),C(465) Button "Confirma" Size C(037),C(012) PIXEL OF oDlgP Action(oDlgP:END(),lSaiE:=.T.)
	@ C(062),C(465) Button "Lançar cotação" Size C(037),C(012) PIXEL OF oDlgP Action (U_LancCota(cProd))
	@ C(076),C(465) Button "Analise Venda" Size C(037),C(012) PIXEL OF oDlgP Action (AnalVen(),lSai:= .f.)
	@ C(090),C(465) Button "Divergencia Ped." Size C(037),C(012) PIXEL OF oDlgP Action (U_DESPNOT(),lSai:= .f.)

	@ C(104),C(465) Button "Atualizar Filial" Size C(037),C(012) PIXEL OF oDlgP Action ATUFILIAL(cProd)
	@ C(118),C(465) Button "Historico" Size C(037),C(012) PIXEL OF oDlgP Action HisPre(cProd)
	@ C(132),C(465) Button "Conhecimento" Size C(037),C(012) PIXEL OF oDlgP Action MsDocument( "SF1", SF1->( Recno() ), 1 )
	@ C(160),C(465) Button "Sair" Size C(037),C(012) PIXEL OF oDlgP Action (lSai:= .f.,oDlgP:END())





	//@ C(142),C(305) Say "Itens a Revisar:" Size C(080),C(008) COLOR CLR_BLACK PIXEL OF oDlgP

	//oReviso:= tMultiget():New(188,390,{|u|if(Pcount()>0,cReviso:=u,cReviso)},oDlgP,200,30,,,,,,.T.,,,,,,.T.)





	ACTIVATE MSDIALOG oDlgP CENTERED


	IF lSaiE
		/*
		// Verificando que o Produto tem Familia
		lFam:= .F.
		cFamil:= POSICIONE("SB1",1,xFilial("SB1")+cProd,"B1_CFAM")
		DbSelectArea("SZ1")
		DbSetOrder(1)
		DbSeek(xFilial("SZ1")+SB1->B1_CFAM)

		If lGerent = .t. .and. cFamil<>SPACE(2) .AND. SZ1->Z1_PADPREC = 'N'

		csql:=" UPDATE SB0010 SET B0_QTD2 = "+cValToChar(nQtdAt)+" "
		csql+="                  ,B0_QTDPR3 = "+cValToChar(nQtdPr)+"  "
		csql+="                  ,B0_DTALTAT = CASE WHEN B0_QTD2 = "+cValToChar(nQtdAt)+" "
		csql+="	                                    THEN CASE WHEN B0_QTDPR3 = "+cValToChar(nQtdPr)+" "
		csql+="			                                      THEN B0_DTALTAT"
		csql+="			                                      ELSE '"+DTOS(DATE())+"'"
		csql+="		                                     END"
		csql+="	                                    ELSE  '"+DTOS(DATE())+"'"
		csql+="                                END		"
		csql+=" FROM SB0010"
		csql+=" LEFT OUTER JOIN SB1010 ON(B1_COD = B0_COD "
		csql+=" 					  AND SB1010.D_E_L_E_T_ = '') "
		csql+=" WHERE B0_FILIAL = '"+xFilial("SZ2")+"'"
		csql+=" AND   B1_CFAM = '"+SB1->B1_CFAM+"'"
		TcSqlExec(csql)
		EndIf

		If !Empty(cBloque) .and. lGerent = .f.
		lFam:= .F.
		Else
		IF cFamil<>SPACE(2) .AND. SZ1->Z1_PADPREC = 'S'
		IF MSGBOX("Deseja Atualizar a Familia do Produto","Observação","YESNO")
		lFam:= .T.
		ELSE
		lFam:= .F.
		ENDIF
		ENDIF
		EndIf
		//// Gravando os Dados na TABELA da PRECIFICAÇÃO

		dbSelectArea("SZ2")
		dbSetOrder(1)
		Dbseek(xFilial("SB0")+cNota+cSerie+cFornece+cLoja+cProd)
		IF FOUND()
		do while SZ2->Z2_FILIAL = xFilial("SB0") .AND. SZ2->Z2_DOC = cNota .AND. SZ2->Z2_SERIE = cSerie .AND. SZ2->Z2_FORNECE = cFornece .AND. SZ2->Z2_LOJA = cLoja .AND. SZ2->Z2_PROD = cProd


		RecLock("SZ2",.F.)
		SZ2->Z2_FRETET := cFrete
		SZ2->Z2_FRETER := cRFrete
		SZ2->Z2_DESCT := cDescar
		SZ2->Z2_DESCR := cRDesc
		SZ2->Z2_SEGUT := cSegcar
		SZ2->Z2_SEGUR := cRSegca
		SZ2->Z2_OUTCUST := cOuCust
		SZ2->Z2_OUTCUSR := cRoutCus
		SZ2->Z2_IPI := cIPI
		SZ2->Z2_COFINS := cCofins
		SZ2->Z2_VALMERC := cVlrBrut
		SZ2->Z2_CUSTOFA := cCustoFa2
		SZ2->Z2_VICMST  := cVICMST
		SZ2->Z2_PSUGER  := cPreSug
		SZ2->Z2_CUSTORE := cCuRepo2
		SZ2->Z2_ICMTRIV := cICMtriV
		SZ2->Z2_CUFINAL :=  cCuFinal
		SZ2->Z2_CREPM := cCuRepo
		SZ2->Z2_CFABM:= cCustoFa
		SZ2->Z2_MAREST := cMarEst2
		SZ2->Z2_VENLIQ := cVenLiq
		SZ2->Z2_PISV   := cPISV
		SZ2->Z2_COFINSV := cCOFINSV
		SZ2->Z2_ICMTRI := cICMtri
		SZ2->Z2_CUFINAV := cCuFinalV
		SZ2->Z2_MARESTV := cMarEst2V
		SZ2->Z2_VENLV   := cVenLV
		SZ2->Z2_PISC    := cPPisC
		SZ2->Z2_PIS     := cPis
		SZ2->Z2_COFINSC := cPCONFC
		SZ2->Z2_PISD    := cPPisD
		SZ2->Z2_COFINSD := cPCONFD
		SZ2->Z2_ICMCRED := cIcmst
		SZ2->Z2_ICMDEB  := cAicmD
		SZ2->Z2_VAATAC  := cVAtac
		SZ2->Z2_VAVAR   := cVAvar
		SZ2->Z2_FAM     := lFam
		SZ2->Z2_PREFIXO := cPrefixo
		SZ2->Z2_NUMTIT  := cNumTit
		SZ2->Z2_FORDES  := cForDesc
		SZ2->Z2_LOJDES  := cLoDes
		SZ2->Z2_VLRBON  := cVboni
		SZ2->Z2_CUSANT  := cCusAnt
		SZ2->Z2_CANREP  := cCusanr
		SZ2->Z2_CANFAB  := cCusanf
		SZ2->Z2_VLRBR   := cVboniR
		SZ2->Z2_VLRDR   := cVdesU
		SZ2->Z2_PICMSC  := cPicmsC
		SZ2->Z2_CCONT   := cCustCont
		SZ2->Z2_PR3PIS  := cPISP3
		SZ2->Z2_PR3COF  := cCOFINSP3
		SZ2->Z2_PR3ICMT := cICMtriP3
		SZ2->Z2_PR3CFIN := cCuFinalP3
		SZ2->Z2_PR3MKP  := vMarPr3
		SZ2->Z2_PR3     := cVenPR3
		If lGerent = .t.
		SZ2->Z2_FLAG    := "OK"
		SZ2->Z2_DATAPRE := DATE()
		Else
		If !Empty(cBloque)
		SZ2->Z2_FLAG    := "BL"
		Else
		SZ2->Z2_FLAG    := "OK"
		SZ2->Z2_DATAPRE := DATE()
		EndIf
		EndIf

		IF lSim
		SZ2->Z2_BONIF   := "S"
		ENDIF
		lBoni:= .t.
		SZ2->Z2_CUSTRAN   := cPrTran
		SZ2->Z2_INDF      := nIdTra
		SZ2->Z2_CRPRES    := cCrdPre
		SZ2->Z2_HORA    := TIME()

		SZ2->(MsUnLock())
		dbskip()
		ENDDO
		ENDIF
		*/

		csql:=" UPDATE SZ2010 SET "
		csql+=" 				 Z2_FRETET = "+cValToChar( ROUND(cFrete,2))+" "
		csql+=" 				,Z2_FRETER = "+cValToChar( ROUND(cRFrete,2))+" "
		csql+=" 				,Z2_DESCT = "+cValToChar( ROUND(cDescar,2))+" "
		csql+=" 				,Z2_DESCR = "+cValToChar( ROUND(cRDesc,2))+" "
		csql+=" 				,Z2_SEGUT = "+cValToChar( ROUND(cSegcar,2))+" "
		csql+=" 				,Z2_SEGUR = "+cValToChar( ROUND(cRSegca,2))+" "
		csql+=" 				,Z2_OUTCUST = "+cValToChar( ROUND(cOuCust,2))+" "
		csql+=" 				,Z2_OUTCUSR = "+cValToChar( ROUND(cRoutCus,2))+" "
		csql+=" 				,Z2_IPI = "+cValToChar( ROUND(cIPI,2))+" "
		csql+=" 				,Z2_COFINS = "+cValToChar( ROUND(cCofins,2))+" "
		csql+=" 				,Z2_VALMERC = "+cValToChar( ROUND(cVlrBrut,2))+" "
		csql+=" 				,Z2_CUSTOFA = "+cValToChar( ROUND(cCustoFa2,2))+" "
		csql+=" 				,Z2_VICMST  = "+cValToChar( ROUND(cVICMST,2))+" "
		csql+=" 				,Z2_PSUGER  = "+cValToChar( ROUND(cPreSug,2))+" "
		csql+=" 				,Z2_CUSTORE = "+cValToChar( ROUND(cCuRepo2,2))+" "
		csql+=" 				,Z2_ICMTRIV = "+cValToChar( ROUND(cICMtriV,2))+" "
		csql+=" 				,Z2_CUFINAL =  "+cValToChar( ROUND(cCuFinal,2))+" "
		csql+=" 				,Z2_CREPM = "+cValToChar( ROUND(cCuRepo,2))+" "
		csql+=" 				,Z2_CFABM = "+cValToChar( ROUND(cCustoFa,2))+" "
		csql+=" 				,Z2_MAREST = "+cValToChar( ROUND(cMarEst2,2))+" "
		csql+=" 				,Z2_VENLIQ = "+cValToChar( ROUND(cVenLiq,2))+" "
		csql+=" 				,Z2_PISV   = "+cValToChar( ROUND(cPISV,2))+" "
		csql+=" 				,Z2_COFINSV = "+cValToChar( ROUND(cCOFINSV,2))+" "
		csql+=" 				,Z2_ICMTRI = "+cValToChar( ROUND(cICMtri,2))+" "
		csql+=" 				,Z2_CUFINAV = "+cValToChar( ROUND(cCuFinalV,2))+" "
		csql+=" 				,Z2_MARESTV = "+cValToChar( ROUND(cMarEst2V,2))+" "
		csql+=" 				,Z2_VENLV   = "+cValToChar( ROUND(cVenLV,2))+" "
		csql+=" 				,Z2_PISC    = "+cValToChar( ROUND(cPPisC,2))+" "
		csql+=" 				,Z2_PIS     = "+cValToChar( ROUND(cPis,2))+" "
		csql+=" 				,Z2_COFINSC = "+cValToChar( ROUND(cPCONFC,2))+" "
		csql+=" 				,Z2_PISD    = "+cValToChar( ROUND(cPPisD,2))+" "
		csql+=" 				,Z2_COFINSD = "+cValToChar( ROUND(cPCONFD,2))+" "
		csql+=" 				,Z2_ICMCRED = "+cValToChar( ROUND(cIcmst,2))+" "
		csql+=" 				,Z2_ICMDEB  = "+cValToChar( ROUND(cAicmD,2))+" "
		csql+=" 				,Z2_VAATAC  = "+cValToChar( ROUND(cVAtac,2))+" "
		csql+=" 				,Z2_VAVAR   = "+cValToChar( ROUND(cVAvar,2))+" "
		If lFam
			csql+=" 				,Z2_FAM     = 'T' "
		ELse
			csql+=" 				,Z2_FAM     = 'F' "
		EndIf
		csql+=" 				,Z2_PREFIXO = '"+cPrefixo+"' "
		csql+=" 				,Z2_NUMTIT  = '"+cNumTit+"' "
		csql+=" 				,Z2_FORDES  = '"+cForDesc+"' "
		csql+=" 				,Z2_LOJDES  = '"+cLoDes+"' "
		
		
    	csql+="                  ,Z2_VLRBON = CASE WHEN Z2_PROD = '"+cProd+"'  THEN "+cValToChar( ROUND(cVboni,2))+" ELSE 0 END " 
		
//		csql+=" 				,Z2_VLRBON  = "+cValToChar( ROUND(cVboni,2))+" "
		
		
		csql+=" 				,Z2_CUSANT  = "+cValToChar( ROUND(cCusAnt,2))+" "
		csql+=" 				,Z2_OUTDESP  = "+cValToChar( ROUND(cOutDsUS,2))+" "
		csql+=" 				,Z2_CANREP  = "+cValToChar( ROUND(cCusanr,2))+" "
		csql+=" 				,Z2_CANFAB  = "+cValToChar( ROUND(cCusanf,2))+" "
		csql+=" 				,Z2_VLRBR   = "+cValToChar( ROUND(cVboniR,2))+" "
		csql+=" 				,Z2_VLRDR   = "+cValToChar( ROUND(cVdesU,2))+" "
		csql+=" 				,Z2_PICMSC  = "+cValToChar( ROUND(cPicmsC,2))+" "
		csql+=" 				,Z2_CCONT   = "+cValToChar( ROUND(cCustCont,2))+" "
		csql+=" 				,Z2_PR3PIS  = "+cValToChar( ROUND(cPISP3,2))+" "
		csql+=" 				,Z2_PR3COF  = "+cValToChar( ROUND(cCOFINSP3,2))+" "
		csql+=" 				,Z2_PR3ICMT = "+cValToChar( ROUND(cICMtriP3,2))+" "
		csql+=" 				,Z2_PR3CFIN = "+cValToChar( ROUND(cCuFinalP3,2))+" "
		csql+=" 				,Z2_PR3MKP  = "+cValToChar( ROUND(vMarPr3,2))+" "
		csql+=" 				,Z2_PR3     = "+cValToChar( ROUND(cVenPR3,2))+" "
		If lGerent = .t.
			csql+=" 					,Z2_FLAG    = 'OK'"
			csql+=" 					,Z2_DATAPRE = '"+ Dtos(DATE()) +"'"
		Else
			If !Empty(cBloque)
				csql+=" 						,Z2_FLAG    = 'BL'"
			Else
				csql+=" 						,Z2_FLAG    = 'OK'"
				csql+=" 						,Z2_DATAPRE = '"+ dtos(DATE()) +"'"
			EndIf
		EndIf
		IF lSim
			csql+=" 					,Z2_BONIF   = 'S'"
		ENDIF
		csql+=" 				,Z2_CUSTRAN   = "+cValToChar( ROUND(cPrTran,2))+" "
		csql+=" 				,Z2_INDF      = "+cValToChar( ROUND(nIdTra,2))+" "
		csql+=" 				,Z2_CRPRES    = "+cValToChar( ROUND(cCrdPre,2))+" "
		csql+=" 				,Z2_HORA     = '"+ TIME() +"' "
		csql+=" 				,Z2_CREPMAT  = "+cValToChar( ROUND(cCuMedAn,2))+" "
		csql+=" 				,Z2_CCONANT  = "+cValToChar( ROUND(cContAnt,2))+" "
		csql+=" WHERE Z2_FILIAL = '"+xFilial("SZ2")+"'"
		csql+=" AND   Z2_DOC = '"+cNota+"'"
		csql+=" AND   Z2_SERIE = '"+cSerie+"'"
		csql+=" AND   Z2_FORNECE = '"+cFornece+"'"
		csql+=" AND   Z2_PROD IN("+cItens+")"
		csql+=" AND   SZ2010.D_E_L_E_T_ = ''"

		If (TCSQLExec(csql) < 0)
			Return MsgStop("TCSQLError() " + TCSQLError())
		Else

		EndIf


		lBoni:= .t.
		If lGerent = .t. .and.  lMantPr = .f.
			csql:=" UPDATE SB0010 SET B0_PVENDA = "+cValToChar(cMarEst2V)+" "
			csql+="                  ,B0_MARESP = "+cValToChar(cMarEst2)+" "
			csql+="                  ,B0_MKPPR3 = "+cValToChar(vMarPr3)+" "
			csql+="                  ,B0_QTD2 =   "+cValToChar(nQtdAt)+" "
			csql+="                  ,B0_QTDPR3 = "+cValToChar(nQtdPr)+"  "
			csql+="                  ,B0_PRV1 = "+cValToChar(round(cVenLV,2))+"  "
			csql+="                  ,B0_PRV2 = "+cValToChar(round(cVenLiq,2))+"  "
			csql+="                  ,B0_PRV6 = "+cValToChar(round(cVenPR3,2))+"  "
			csql+="                  ,B0_ALTERA = "+Dtos(DATE())+"  "
			csql+="                  ,B0_DTALTAT = CASE WHEN B0_QTD2 = "+cValToChar(nQtdAt)+" "
			csql+="	                                    THEN CASE WHEN B0_QTDPR3 = "+cValToChar(nQtdPr)+" "
			csql+="			                                      THEN B0_DTALTAT"
			csql+="			                                      ELSE '"+DTOS(DATE())+"'"
			csql+="		                                     END"
			csql+="	                                    ELSE  '"+DTOS(DATE())+"'"
			csql+="                                END
			csql+=" WHERE B0_FILIAL = '"+xFilial("SZ2")+"'"
			csql+=" AND   B0_COD IN("+cItens+")"

			If (TCSQLExec(csql) < 0)
				Return MsgStop("TCSQLError() " + TCSQLError())
			Else

			EndIf
		Else
			csql:=" UPDATE SB0010 SET B0_PRV1 = "+cValToChar(round(cVenLV,2))+"  "
			csql+="                  ,B0_PRV2 = "+cValToChar(round(cVenLiq,2))+"  "
			csql+="                  ,B0_PRV6 = "+cValToChar(round(cVenPR3,2))+"  "
			csql+="                  ,B0_ALTERA = "+Dtos(DATE())+"  "
			csql+=" WHERE B0_FILIAL = '"+xFilial("SZ2")+"'"
			csql+=" AND   B0_COD IN("+cItens+")"

			If (TCSQLExec(csql) < 0)
				Return MsgStop("TCSQLError() " + TCSQLError())
			Else

			EndIf

		EndIf

		csql:=" UPDATE SB2010 SET    B2_CFINVAR = "+cValToChar(cCuFinalV)+" "
		csql+=" 					,B2_CFINATA = "+cValToChar(cCuFinal)+" "
		csql+=" 					,B2_CREPOS  = "+cValToChar(cCuRepo2)+" "
		csql+=" 					,B2_CFAB    = "+cValToChar(cCustoFa2)+" "
		csql+=" 					,B2_CFABM   = "+cValToChar(cCustoFa)+" "
		csql+=" 					,B2_CREPM   = "+cValToChar(cCuRepo)+" "
		csql+=" 					,B2_CCONT   = "+cValToChar(cCustCont)+" "
		csql+=" 					,B2_CUSTRAN = "+cValToChar(cPrTran)+" "
		csql+=" 					,B2_CFINPR3 = "+cValToChar(cCuFinalP3)+" "
		csql+=" WHERE B2_FILIAL = '"+xFilial("SZ2")+"'"
		csql+=" AND   B2_COD  IN("+cItens+")"

		If (TCSQLExec(csql) < 0)
			Return MsgStop("TCSQLError() " + TCSQLError())
		Else

		EndIf

		/*
		//////

		// Atualizando Preços de ATACADO e VAREJO LOJA


		IF lFam

		// Coloca no array as familia do produto
		Private oDlgfa
		Private oOk  := LoadBitMap(GetResources(), "LBOK")
		Private oNo  := LoadBitMap(GetResources(), "LBNO")
		Private aArFam:= {}
		Private oArFam


		dbSelectArea("SB1")
		SB1->(DbOrderNickName("FAMILIA"))
		dbseek(xFilial("SB1")+cFamil)
		mSeqf:=0
		DO WHILE SB1->B1_CFAM = cFamil  .AND. !SB1->(Eof())
		if SB1->B1_COD = cProd
		dbskip()
		loop
		endif
		aadd(aArFam,{' ',SB1->B1_COD,SB1->B1_DESC,SB1->B1_UM})
		mSeqf++
		dbskip()

		ENDDO

		IF mSeqf = 0
		MsgInfo("Não Existe Produto com Esta Familia")
		return .t.
		ENDIF



		Private oOk  := LoadBitMap(GetResources(), "LBOK")
		Private oNo  := LoadBitMap(GetResources(), "LBNO")


		DEFINE MSDIALOG _oDlgfa TITLE OemToAnsi("Escolha os Produtos Referente a Familia") FROM C(0),C(0) To C(200),C(700) PIXEL OF oMainWnd //17
		oFont  := TFont():New("Courier New",0,14,,.f.,,,,.f.,.f.)

		oArFam := TWBrowse():New( c(10),c(5),c(340),c(075),,{" ","Produto","Descrição","Unidade"},,_oDlgfa,,,,,,,,,,,,.F.,,.T.,,.F.,,,)

		oArFam:SetArray(aArFam)
		oArFam:bLine := {|| { iif(aArFam[oArFam:nAt,1]="*",oOk,oNo), aArFam[oArFam:nAt,2] ,aArFam[oArFam:nAt,3],aArFam[oArFam:nAt,4]}}

		oArFam:bLDBLCLICK := {|| aArFam[oArFam:nAt,1] := IIF(aArFam[oArFam:nAt,1] = '*',' ','*'),oArFam:refresh() }

		_lOk := .f.

		@ C(088),C(220) Button "Confirma os Produtos"           Size C(80),C(10) Action  _oDlgfa:End()    pixel of _oDlgfa

		Activate Dialog _oDlgfa CENTERED



		nCnot:= 0

		for _nI := 1 to len(aArFam)
		if aArFam[_nI,1] = '*'
		If lGerent = .t. .and.  lMantPr = .f.

		csql:=" UPDATE SB0010 SET B0_PVENDA = "+cValToChar(cMarEst2V)+" "
		csql+="                  ,B0_MARESP = "+cValToChar(cMarEst2)+" "
		csql+="                  ,B0_MKPPR3 = "+cValToChar(vMarPr3)+" "
		csql+="                  ,B0_QTD2 = "+cValToChar(nQtdAt)+" "
		csql+="                  ,B0_QTDPR3 = "+cValToChar(nQtdPr)+"  "
		csql+="                  ,B0_DTALTAT = CASE WHEN B0_QTD2 = "+cValToChar(nQtdAt)+" "
		csql+="	                                    THEN CASE WHEN B0_QTDPR3 = "+cValToChar(nQtdPr)+" "
		csql+="			                                      THEN B0_DTALTAT"
		csql+="			                                      ELSE '"+DTOS(DATE())+"'"
		csql+="		                                     END"
		csql+="	                                    ELSE  '"+DTOS(DATE())+"'"
		csql+="                                END
		csql+=" WHERE B0_FILIAL = '"+xFilial("SZ2")+"'"
		csql+=" AND   B0_COD = '"+aArFam[_nI,2]+"'"
		TcSqlExec(csql)

		EndIf

		dbSelectArea("SB0")
		dbsetorder(1)
		dbseek(xFilial("SB0")+aArFam[_nI,2])
		if Found()
		RecLock("SB0",.F.)
		if round(SB0->B0_PRV2,2) <> round(cVenLiq,2) .OR. round(SB0->B0_PRV1,2) <> round(cVenLV,2) .OR. round(SB0->B0_PRV6,2) <> round(cVenPR3,2)
		SB0->B0_PRV1  := round(cVenLV,2)
		SB0->B0_PRV2  := round(cVenLiq,2)
		SB0->B0_PRV6  := round(cVenPR3,2)
		SB0->B0_ALTERA := DATE()
		endif

		SB0->(MsUnLock())
		ENDIF

		dbSelectArea("DA1")
		dbsetorder(2)
		dbseek(xFilial("DA1")+aArFam[_nI,2])

		DO WHILE DA1->DA1_FILIAL  = xFilial("DA1") .AND.  DA1->DA1_CODPRO = aArFam[_nI,2] .AND.  !DA1->(Eof())
		RecLock("DA1",.F.)
		DA1->DA1_PRCVEN  := cVenLiq+((cVenLiq*DA1_PVEND)/100)
		DA1->(MsUnLock())
		dbskip()
		ENDDO

		endif


		next


		dbSelectArea("SB0")
		dbsetorder(1)
		dbseek(xFilial("SB0")+cProd)
		RecLock("SB0",.F.)
		if round(SB0->B0_PRV2,2) <> round(cVenLiq,2) .OR. round(SB0->B0_PRV1,2) <> round(cVenLV,2) .OR. round(SB0->B0_PRV6,2) <> round(cVenPR3,2)
		SB0->B0_PRV1  := round(cVenLV,2)
		SB0->B0_PRV2  := round(cVenLiq,2)
		SB0->B0_PRV6  := round(cVenPR3,2)
		SB0->B0_ALTERA := DATE()
		endif
		SB0->(MsUnLock())



		// Atualizando a tabelas de Preço Venda Externa

		dbSelectArea("DA1")
		dbsetorder(2)
		dbseek(xFilial("DA1")+cProd)

		DO WHILE DA1->DA1_FILIAL  = xFilial("DA1") .AND.  DA1->DA1_CODPRO = cProd .AND.  !DA1->(Eof())
		RecLock("DA1",.F.)
		DA1->DA1_PRCVEN  := cVenLiq+((cVenLiq*DA1_PVEND)/100)
		DA1->(MsUnLock())
		dbskip()
		ENDDO

		*/
		/*

		// Atualizando Custo
		dbSelectArea("SB2")
		dbSetOrder(1)
		dBseek(xFilial("SB2")+cProd+"01")

		IF FOUND()
		RecLock('SB2',.F.)
		SB2->B2_CM1   := ROUND(cCuFinal,2)
		SB2->B2_VATU1 := ROUND(cCuFinal,2)*B2_QATU
		SB2->B2_CREPOS   := ROUND(cCuRepo,2)
		SB2->B2_CFAB     := ROUND(cCustoFa,2)
		SB2->(MsUnlock())
		ENDIF

		*/

		//endif

		//


		// Verificar que foi usado Bonificção
		if cVboni <> 0
			// Atualizando a Bonificação
			dbSelectArea("SZB")
			RecLock('SZB',.T.)
			SZB->ZB_FILIAL  := xFilial("SD1")
			SZB->ZB_FORNECE := cFornece
			SZB->ZB_LOJA    := cLoja
			SZB->ZB_NOTA    := cNota
			SZB->ZB_SERIE   := cSerie
			SZB->ZB_VALOR   := cVboni
			SZB->ZB_DATA    := Date()
			SZB->ZB_TIPO    := "D"
			SZB->ZB_EMISSAO := cEmissao
			SZB->ZB_CGC     := cCGC8
			SZB->ZB_OBSERV  := "PRECIFICACAO DE PRODUTO"
			SZB->ZB_TPMOV   := '1'
			SZB->ZB_ORIG    := 'PRECO'
			SZB->ZB_USUAR   := Alltrim(cUserName)
			SZB->(MsUnlock())

			// Baixa na Bonificacao
			dbSelectArea("SZC")
			dbSetOrder(2)
			dBseek(xFilial("SZC")+cCgc8)

			IF FOUND()
				RecLock('SZC',.F.)
				SZC->ZC_SALDO -= cVboni
				SZC->ZC_ULTDATA := Date()
				SZC->(MsUnlock())
			ENDIF
		endif

		//

		aListBox2 := {}
		dbSelectArea("SZ2")
		dbSetOrder(1)
		Dbseek(xFilial("SB0")+cNota+cSerie+cFornece+cLoja)

		DO WHILE SZ2->Z2_DOC = cNota .AND. SZ2->Z2_SERIE = cSerie .AND. SZ2->Z2_FORNECE = cFornece   .AND. SZ2->Z2_LOJA = cLoja .AND. !SZ2->(Eof())
			aadd(aListBox2,{SZ2->Z2_FLAG,SZ2->Z2_PROD,POSICIONE("SB1",1,xFilial("SB1")+SZ2->Z2_PROD,"B1_DESC"),TRANS(SZ2->Z2_QUANT,"@E 99999.999"),TRANS(SZ2->Z2_VUNIT,"@E 99999.99") })
			SZ2->(DbSkip())
		ENDDO

		oListBox2:SetArray(aListBox2)

		oListBox2:bLine := {|| {;
		IIF(aListBox2[oListBox2:nAT,01] = 'OK',oVerde,IIF(aListBox2[oListBox2:nAT,01] = 'BL',oVerme,oBranc)),;//aListBox2[oListBox2:nAT,01],;
		aListBox2[oListBox2:nAT,02],;
		aListBox2[oListBox2:nAT,03],;
		aListBox2[oListBox2:nAT,04],;
		aListBox2[oListBox2:nAT,05]}}


		oListBox2:Refresh()

	ELSE

		// RECUPERAR O VALOR DO DESCONTO QUANDO NÃO HA CONFIRMAÇÃO
		if lsimde = .f. .and. cVdesc<> 0
			cVdescA := cVdescA + cDDesU
		endif

		// RECUPERAR O VALOR DA BONIFICAÇÃO QUANDO NÃO HA CONFIRMAÇÃO

		cVlrBoA := cVbonSa

		cOutDsAN := cOutDECo // RECUPERANDO O SALDO DA DESPESAS PARA RECUPERAR QUANDO NÃO FOR CONFIRMADO
		cOutDsUS := 0



		// Atualizando o listbox quando não ha confirmação
		aListBox2 := {}
		dbSelectArea("SZ2")
		dbSetOrder(1)
		Dbseek(xFilial("SB0")+cNota+cSerie+cFornece+cLoja)

		DO WHILE SZ2->Z2_DOC = cNota .AND. SZ2->Z2_SERIE = cSerie .AND. SZ2->Z2_FORNECE = cFornece   .AND. SZ2->Z2_LOJA = cLoja .AND. !SZ2->(Eof())
			aadd(aListBox2,{SZ2->Z2_FLAG,SZ2->Z2_PROD,POSICIONE("SB1",1,xFilial("SB1")+SZ2->Z2_PROD,"B1_DESC"),TRANS(SZ2->Z2_QUANT,"@E 99999.999"),TRANS(SZ2->Z2_VUNIT,"@E 99999.99") })
			SZ2->(DbSkip())
		ENDDO

		oListBox2:SetArray(aListBox2)

		oListBox2:bLine := {|| {;
		IIF(aListBox2[oListBox2:nAT,01] = 'OK',oVerde,IIF(aListBox2[oListBox2:nAT,01] = 'BL',oVerme,oBranc)),;//aListBox2[oListBox2:nAT,01],;
		aListBox2[oListBox2:nAT,02],;
		aListBox2[oListBox2:nAT,03],;
		aListBox2[oListBox2:nAT,04],;
		aListBox2[oListBox2:nAT,05]}}


		oListBox2:Refresh()







	ENDIF


RETURN

Static Function HisPre(cProd)

	// Variaveis Private da Funcao
	Private _oDlghist				// Dialog Principal
	// Variaveis que definem a Acao do Formulario
	Private VISUAL := .F.
	Private INCLUI := .F.
	Private ALTERA := .F.
	Private DELETA := .F.
	// Privates das ListBoxes
	Private aListBoAt := {}
	Private aListBoVr := {}
	Private oListBoAt
	Private oListBoVr
	Private aListBoP3 := {}
	Private oListBoP3

	_cQuery:=" SELECT Z2_DATAPRE"
	_cQuery+=" 	  ,D1_TES"
	_cQuery+=" 	  ,D1_CF"
	_cQuery+=" 	  ,Z2_CUSTOFA"
	_cQuery+=" 	  ,Z2_CFABM"
	_cQuery+="    ,Z2_FRETER"
	_cQuery+=" 	  ,Z2_IPI"
	_cQuery+=" 	  ,Z2_VICMST"
	_cQuery+=" 	  ,Z2_CUSTORE"
	_cQuery+=" 	  ,Z2_CREPM"
	_cQuery+=" 	  ,Z2_VENLV AS VEN_VAR"
	_cQuery+=" 	  ,Z2_PIS AS PIS_ATC"
	_cQuery+=" 	  ,Z2_COFINS AS COF_ATC"
	_cQuery+=" 	  ,Z2_ICMTRI AS ICM_ATC"
	_cQuery+=" 	  ,Z2_CUFINAL AS CFIN_ATC"
	_cQuery+=" 	  ,ROUND((((Z2_CUFINAL/Z2_VENLIQ)-1)*(-100)),2) AS MKP_ATC"
	_cQuery+=" 	  ,Z2_VENLIQ AS VEN_ATC"
	_cQuery+=" 	  ,Z2_PISV AS PIS_VAR"
	_cQuery+=" 	  ,Z2_COFINSV AS COF_VAR"
	_cQuery+=" 	  ,Z2_ICMTRIV AS ICM_VAR"
	_cQuery+=" 	  ,Z2_CUFINAV AS CFIN_VAR"
	_cQuery+=" 	  ,ROUND((((Z2_CUFINAV/Z2_VENLV)-1)*(-100)),2) AS MKP_VAR"
	_cQuery+=" 	  ,Z2_PR3 AS VEN_PR3"
	_cQuery+=" 	  ,Z2_PR3PIS AS PIS_PR3"
	_cQuery+=" 	  ,Z2_PR3COF AS COF_PR3"
	_cQuery+=" 	  ,Z2_PR3ICMT AS ICM_PR3"
	_cQuery+=" 	  ,Z2_PR3CFIN AS CFIN_PR3"
	_cQuery+=" 	  ,CASE WHEN Z2_PR3 = 0 THEN 0 ELSE ROUND((((Z2_PR3CFIN/Z2_PR3)-1)*(-100)),2) END AS MKP_PR3"
	_cQuery+=" FROM SZ2010"
	_cQuery+=" LEFT OUTER JOIN SD1010 ON(D1_FILIAL  = Z2_FILIAL"
	_cQuery+=" 					  AND D1_DOC     = Z2_DOC"
	_cQuery+=" 					  AND D1_SERIE   = Z2_SERIE"
	_cQuery+=" 					  AND D1_FORNECE = Z2_FORNECE"
	_cQuery+=" 					  AND D1_COD     = Z2_PROD"
	_cQuery+=" 					  AND SD1010.D_E_L_E_T_ = '')"
	_cQuery+=" WHERE Z2_FILIAL = '"+xFilial("SZ2")+"'"
	_cQuery+=" AND   Z2_PROD = '"+cProd+"'"
	_cQuery+=" AND   SZ2010.D_E_L_E_T_ = ''"
	_cQuery+=" AND   Z2_FLAG = 'OK'"
	_cQuery+=" AND   Z2_DATAPRE >= '"+DTOS(DATE()-180)+"'"
	_cQuery+=" AND   Z2_DATAPRE <> ''"
	_cQuery+=" ORDER BY 1 DESC"
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),"TRB",.T.,.T.)

	Aadd(aListBoAt,{"HOJE",SD1->D1_TES,SD1->D1_CF,round(cCustoFa2,2),round(cCustoFa,2),round(cRfrete,2),round(cIPI,2),round(cVICMST,2),round(cCuRepo2,2),round(cCuRepo,2),round(cPIS,2),round(cCOFINS,2),round(cICMtri,2),round(cCuFinal,2),round(cMarEst2,2),round(cVenLiq,2)})
	Aadd(aListBoVr,{"HOJE",SD1->D1_TES,SD1->D1_CF,round(cCustoFa2,2),round(cCustoFa,2),round(cRfrete,2),round(cIPI,2),round(cVICMST,2),round(cCuRepo2,2),round(cCuRepo,2),round(cPISV,2),round(cCOFINSV,2),round(cICMtriV,2),round(cCuFinalV,2),round(cMarEst2V,2),round(cVenLV,2)})
	Aadd(aListBoP3,{"HOJE",SD1->D1_TES,SD1->D1_CF,round(cCustoFa2,2),round(cCustoFa,2),round(cRfrete,2),round(cIPI,2),round(cVICMST,2),round(cCuRepo2,2),round(cCuRepo,2),round(cPISP3,2),round(cCOFINSP3,2),round(cICMtriP3,2),round(cCuFinalP3,2),round(vMarPr3,2),round(cVenPR3,2)})

	dbSelectArea('TRB')
	TRB->(dbGoTop())
	While !TRB->(EOF())

		Aadd(aListBoAt,{DTOC(STOD(TRB->Z2_DATAPRE)),TRB->D1_TES,TRB->D1_CF,TRB->Z2_CUSTOFA,TRB->Z2_CFABM,TRB->Z2_FRETER,TRB->Z2_IPI,TRB->Z2_VICMST,TRB->Z2_CUSTORE,TRB->Z2_CREPM,TRB->PIS_ATC,TRB->COF_ATC,TRB->ICM_ATC,TRB->CFIN_ATC,TRB->MKP_ATC,TRB->VEN_ATC})
		Aadd(aListBoVr,{DTOC(STOD(TRB->Z2_DATAPRE)),TRB->D1_TES,TRB->D1_CF,TRB->Z2_CUSTOFA,TRB->Z2_CFABM,TRB->Z2_FRETER,TRB->Z2_IPI,TRB->Z2_VICMST,TRB->Z2_CUSTORE,TRB->Z2_CREPM,TRB->PIS_VAR,TRB->COF_VAR,TRB->ICM_VAR,TRB->CFIN_VAR,TRB->MKP_VAR,TRB->VEN_VAR})
		Aadd(aListBoP3,{DTOC(STOD(TRB->Z2_DATAPRE)),TRB->D1_TES,TRB->D1_CF,TRB->Z2_CUSTOFA,TRB->Z2_CFABM,TRB->Z2_FRETER,TRB->Z2_IPI,TRB->Z2_VICMST,TRB->Z2_CUSTORE,TRB->Z2_CREPM,TRB->PIS_PR3,TRB->COF_PR3,TRB->ICM_PR3,TRB->CFIN_PR3,TRB->MKP_PR3,TRB->VEN_PR3})

		TRB->(dbSkip()) // Avanca o ponteiro do registro no arquivo
	EndDo
	TRB->(DBCLOSEAREA())

	DEFINE MSDIALOG _oDlghist TITLE "Historico de Precificacao" FROM C(178),C(181) TO C(607),C(967) PIXEL

	// Cria Componentes Padroes do Sistema
	@ C(001),C(002) Say "Varejo" Size C(022),C(008) COLOR CLR_BLACK PIXEL OF _oDlghist
	@ C(070),C(003) Say "Atacado" Size C(112),C(008) COLOR CLR_BLACK PIXEL OF _oDlghist
	@ C(137),C(003) Say "Preço 3" Size C(112),C(008) COLOR CLR_BLACK PIXEL OF _oDlghist
	@ C(203),C(348) Button "Sair" Size C(037),C(012) PIXEL OF _oDlghist Action _oDlghist:END()

	// Chamadas das ListBox do Sistema
	fListBoVr()
	fListBoAt()
	fListBoP3()

	ACTIVATE MSDIALOG _oDlghist CENTERED

Return(.T.)


Static Function fListBoVr()

	// Para editar os Campos da ListBox inclua a linha abaixo
	// na opcao de DuploClick da mesma, ou onde for mais conveniente
	// lembre-se de mudar a picture respeitando a coluna a ser editada
	// PS: Para habilitar o DuploClick selecione a opção MarkBrowse da
	//     ListBox para SIM.
	// lEditCell( aListBox, oListBox, "@!", oListBox:ColPos )

	@ C(008),C(001) ListBox oListBoVr Fields ;
	HEADER "Data","TES","CFOP","C Fabrica","C Fab Med","Frete","IPI","Icms ST","C Reposicao","C Rep Med","Pis","Cofins","Icms","C Final","(%) Mkp","Pr Venda";
	Size C(395),C(060) Of _oDlghist Pixel;
	ColSizes 30,20,20,30,30,30,30,30,30,30,30,30,30
	oListBoVr:SetArray(aListBoVr)

	// Carrege aqui sua array da Listbox
	If Empty(aListBoVr)
		Aadd(aListBoVr,{"","",""," "," "," "," ","","","","","","","","",""})
	EndIf

	oListBoVr:bLine := {|| {;
	aListBoVr[oListBoVr:nAT,01],;
	aListBoVr[oListBoVr:nAT,02],;
	aListBoVr[oListBoVr:nAT,03],;
	aListBoVr[oListBoVr:nAT,04],;
	aListBoVr[oListBoVr:nAT,05],;
	aListBoVr[oListBoVr:nAT,06],;
	aListBoVr[oListBoVr:nAT,07],;
	aListBoVr[oListBoVr:nAT,08],;
	aListBoVr[oListBoVr:nAT,09],;
	aListBoVr[oListBoVr:nAT,10],;
	aListBoVr[oListBoVr:nAT,11],;
	aListBoVr[oListBoVr:nAT,12],;
	aListBoVr[oListBoVr:nAT,13],;
	aListBoVr[oListBoVr:nAT,14],;
	aListBoVr[oListBoVr:nAT,15],;
	aListBoVr[oListBoVr:nAT,16]}}
Return Nil


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³fListBox1() ³ Autor ³ Alexandre Bueno da Si ³ Data ³18/04/2016³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Montagem da ListBox                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fListBoAt()

	// Para editar os Campos da ListBox inclua a linha abaixo
	// na opcao de DuploClick da mesma, ou onde for mais conveniente
	// lembre-se de mudar a picture respeitando a coluna a ser editada
	// PS: Para habilitar o DuploClick selecione a opção MarkBrowse da
	//     ListBox para SIM.
	// lEditCell( aListBox, oListBox, "@!", oListBox:ColPos )

	@ C(075),C(001) ListBox oListBoAt Fields ;
	HEADER "Data","TES","CFOP","C Fabrica","C Fab Med","Frete","IPI","Icms ST","C Reposicao","C Rep Med","Pis","Cofins","Icms","C Final","(%) Mkp","Pr Venda";
	Size C(395),C(060) Of _oDlghist Pixel;
	ColSizes 30,20,20,30,30,30,30,30,30,30,30,30,30
	oListBoAt:SetArray(aListBoAt)

	// Carrege aqui sua array da Listbox
	If Empty(aListBoAt)
		Aadd(aListBoAt,{"","",""," "," "," "," ","","","","","","","","",""})
	EndIf
	oListBoAt:bLine := {|| {;
	aListBoAt[oListBoAt:nAT,01],;
	aListBoAt[oListBoAt:nAT,02],;
	aListBoAt[oListBoAt:nAT,03],;
	aListBoAt[oListBoAt:nAT,04],;
	aListBoAt[oListBoAt:nAT,05],;
	aListBoAt[oListBoAt:nAT,06],;
	aListBoAt[oListBoAt:nAT,07],;
	aListBoAt[oListBoAt:nAT,08],;
	aListBoAt[oListBoAt:nAT,09],;
	aListBoAt[oListBoAt:nAT,10],;
	aListBoAt[oListBoAt:nAT,11],;
	aListBoAt[oListBoAt:nAT,12],;
	aListBoAt[oListBoAt:nAT,13],;
	aListBoAt[oListBoAt:nAT,14],;
	aListBoAt[oListBoAt:nAT,15],;
	aListBoAt[oListBoAt:nAT,16]}}
Return Nil

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³fListBoxVr()³ Autor ³ Alexandre Bueno da Si ³ Data ³18/04/2016³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Montagem da ListBox                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/


Static Function fListBoP3()

	// Para editar os Campos da ListBox inclua a linha abaixo
	// na opcao de DuploClick da mesma, ou onde for mais conveniente
	// lembre-se de mudar a picture respeitando a coluna a ser editada
	// PS: Para habilitar o DuploClick selecione a opção MarkBrowse da
	//     ListBox para SIM.
	// lEditCell( aListBox, oListBox, "@!", oListBox:ColPos )

	@ C(142),C(001) ListBox oListBoP3 Fields ;
	HEADER "Data","TES","CFOP","C Fabrica","C Fab Med","Frete","IPI","Icms ST","C Reposicao","C Rep Med","Pis","Cofins","Icms","C Final","(%) Mkp","Pr Venda";
	Size C(395),C(060) Of _oDlghist Pixel;
	ColSizes 30,20,20,30,30,30,30,30,30,30,30,30,30
	oListBoP3:SetArray(aListBoP3)

	// Carrege aqui sua array da Listbox
	If Empty(aListBoP3)
		Aadd(aListBoP3,{"","",""," "," "," "," ","","","","","","","","",""})
	EndIf

	oListBoP3:bLine := {|| {;
	aListBoP3[oListBoP3:nAT,01],;
	aListBoP3[oListBoP3:nAT,02],;
	aListBoP3[oListBoP3:nAT,03],;
	aListBoP3[oListBoP3:nAT,04],;
	aListBoP3[oListBoP3:nAT,05],;
	aListBoP3[oListBoP3:nAT,06],;
	aListBoP3[oListBoP3:nAT,07],;
	aListBoP3[oListBoP3:nAT,08],;
	aListBoP3[oListBoP3:nAT,09],;
	aListBoP3[oListBoP3:nAT,10],;
	aListBoP3[oListBoP3:nAT,11],;
	aListBoP3[oListBoP3:nAT,12],;
	aListBoP3[oListBoP3:nAT,13],;
	aListBoP3[oListBoP3:nAT,14],;
	aListBoP3[oListBoP3:nAT,15],;
	aListBoP3[oListBoP3:nAT,16]}}
Return Nil


STATIC FUNCTION Vnota(nNota,nSerie,nFornec,nLoja)
	dbSelectArea("SF1")
	dbSetOrder(1)
	Dbseek(xFilial("SF1")+nNota+nSerie+nFornec+nLoja)
	if !found()
		alert("Nota Não Encontrada Verifique !")
		return .F.
	ENDIF
	cVlrBrut:= SF1->F1_VALMERC
	cFrete := SF1->F1_FRETE
	cSegcar := SF1->F1_SEGURO
	cVdesc := SF1->F1_DESCONT
	cVdescAC :=SF1->F1_DESCONT

	//cVdescA := SF1->F1_DESCONT
	dbSelectArea("SM0")
	cEst :=SM0->M0_ESTCOB

	//cCGC8:= POSICIONE("SA2",1,xFilial("SA2")+nFornec+nLoja,"LEFT(A2_CGC,8)")
	cCGC8:=nFornec

	// Verificando se existe Bofinicação

	_cQry:= " SELECT *"
	_cQry+= " FROM ZZP010"
	_cQry+= " WHERE (ZZP_PRINCI = '"+nFornec+"' OR ZZP_FORN = '"+nFornec+"')"
	_cQry+= " AND    D_E_L_E_T_ = ''"
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQry),"TRB1",.T.,.T.)

	DbSelectarea("TRB1")
	While !TRB1->(Eof())
		If TRB1->ZZP_PRINCI = nFornec
			cCGC8:=TRB1->ZZP_PRINCI
			Exit
		ElseIf TRB1->ZZP_FORN = nFornec
			cCGC8:=TRB1->ZZP_PRINCI
			Exit
		EndIf
		TRB1->(DBSKIP())
	End

	TRB1->(DBCLOSEAREA())



	dbSelectArea("SZC")
	dbSetOrder(2)
	Dbseek(xFilial("SZC")+cCGC8)
	if found()
		cVlrBoni:= SZC->ZC_SALDO
	else
		cVlrBoni:= 0
	endif
	//cVlrBoA := cVlrBoni

	//

	// Buscando Conhecimento de Frete
	dbSelectArea("SF8")
	dbSetOrder(2)
	Dbseek(xFilial("SF8")+nNota+nSerie+nFornec+nLoja)

	if found()
		aNoFre:= {}
		DO WHILE SF8->F8_FILIAL = xFilial("SF8") .AND. SF8->F8_NFORIG = nNota  .AND. SF8->F8_SERORIG = nSerie .AND. SF8->F8_FORNECE = nFornec .AND. SF8->F8_LOJA = nLoja
			AADD(aNoFre,{SF8->F8_NFDIFRE,SF8->F8_SEDIFRE,SF8->F8_TRANSP,SF8->F8_LOJTRAN})
			dbskip()
		ENDDO


		cVfreEX := 0

		for _nI := 1 to len(aNoFre)

			cNfreEX:= aNoFre[_nI,1]
			cSfreEX:= aNoFre[_nI,2]
			cFfreEX:= aNoFre[_nI,3]
			cLfreEX:= aNoFre[_nI,4]




			//	cNfreEX:= SF8->F8_NFDIFRE
			//	cSfreEX:= SF8->F8_SEDIFRE
			//	cFfreEX:= SF8->F8_TRANSP
			//	cLfreEX:= SF8->F8_LOJTRAN





			// Buscar valor do Frete
			dbSelectArea("SF1")
			dbSetOrder(1)
			Dbseek(xFilial("SF1")+cNfreEX+cSfreEX+cFfreEX+cLfreEX)

			cVfreEX += SF1->F1_VALMERC // Valor do Frete

			//	ELSE
			//	cVfreEX := 0
			//	ENDIF



			dbSelectArea("SF8")
			dbSetOrder(3)
			Dbseek(xFilial("SF8")+cNfreEX+cSfreEX+cFfreEX+cLfreEX)
			IF FOUND()

				cToNFEX := 0
				cVMerNEX := 0       //Variavel guarda o valor da Nota Precificada
				DO WHILE SF8->F8_FILIAL = xFilial("SF8") .AND. SF8->F8_NFDIFRE = cNfreEX .AND. SF8->F8_SEDIFRE = cSfreEX .AND. SF8->F8_TRANSP = cFfreEX .AND. SF8->F8_LOJTRAN = cLfreEX

					cNoriEX:= SF8->F8_NFORIG
					cSoriEX:= SF8->F8_SERORIG
					cForiEX:= SF8->F8_FORNECE
					cLoriEX:= SF8->F8_LOJA

					dbSelectArea("SF1")
					dbSetOrder(1)
					Dbseek(xFilial("SF1")+cNoriEX+cSoriEX+cForiEX+cLoriEX)
					IF FOUND()
						cToNFEX += SF1->F1_VALMERC
						IF nNota = SF1->F1_DOC  .AND. nSerie = SF1->F1_SERIE .AND. nFornec = SF1->F1_FORNECE .AND. nLoja = SF1->F1_LOJA
							cVMerNEX :=SF1->F1_VALMERC
						ENDIF
					ENDIF

					dbSelectArea("SF8")
					dbskip()

				ENDDO




				//		cPerFEX:= (cVMerNEX / cToNFEX)*100  // obtendo o percentual da nota
				//		cFreteEX :=(cVfreEX*cPerFEX)/100    //obtendo o valor do Frete
			endif

		NEXT
		cPerFEX:= (cVMerNEX / cToNFEX)*100  // obtendo o percentual da nota
		cFreteEX :=(cVfreEX*cPerFEX)/100    //obtendo o valor do Frete


	endif



	// A Variavel ( cVpref ) é para verificar que algum produto já foi precificado para anular  os campos de frete,descarga e outros custos


	aListBox2 := {}

    cOutDsAN:= 0

	dbSelectArea("SZ2")
	dbSetOrder(1)
	Dbseek(xFilial("SB0")+nNota+nSerie+nFornec+nLoja)
	IF !FOUND()
		dbSelectArea("SD1")
		dbSetOrder(1)
		Dbseek(xFilial("SD1")+nNota+nSerie+nFornec+nLoja)

		DO WHILE SD1->D1_DOC = nNota .AND. SD1->D1_SERIE = nSerie .AND. SD1->D1_FORNECE = nFornec  .AND. SD1->D1_LOJA = nLoja .AND. !SD1->(Eof())
			cAProduto:= D1_COD
			cAQuant := D1_QUANT
			cAvunit := D1_VUNIT

			dbSelectArea("SZ2")
			dbSetOrder(1)
			RecLock("SZ2",.T.)
			SZ2->Z2_FILIAL := xFilial("SB0")
			SZ2->Z2_DOC := cNota
			SZ2->Z2_SERIE := cSerie
			SZ2->Z2_FORNECE := cFornece
			SZ2->Z2_LOJA := cLoja
			SZ2->Z2_EMISSAO := cEmissao
			SZ2->Z2_PROD   := cAProduto
			SZ2->Z2_QUANT  := cAQuant
			SZ2->Z2_VUNIT  := cAvunit
			SZ2->(MsUnLock())

			dbSelectArea("SD1")

			SD1->(DbSkip())
		ENDDO

	ENDIF

	dbSelectArea("SZ2")
	dbSetOrder(1)
	Dbseek(xFilial("SB0")+nNota+nSerie+nFornec+nLoja)

	DO WHILE SZ2->Z2_DOC = nNota .AND. SZ2->Z2_SERIE = nSerie .AND. SZ2->Z2_FORNECE = nFornec   .AND. SZ2->Z2_LOJA = nLoja .AND. !SZ2->(Eof())
		IF SZ2->Z2_FLAG = "OK"
			cVpref := .T.
			lBoni  := .T.
			lDesc  := .T.
			lOdes  := .T.
		ENDIF

		IF SZ2->Z2_BONIF ="S"
			lSim:= .T.
		ENDIF

		aadd(aListBox2,{SZ2->Z2_FLAG,SZ2->Z2_PROD,POSICIONE("SB1",1,xFilial("SB1")+SZ2->Z2_PROD,"B1_DESC"),TRANS(SZ2->Z2_QUANT,"@E 99999.999"),TRANS(SZ2->Z2_VUNIT,"@E 99999.99")})

		cVlrBoA += SZ2->Z2_VLRBON
		cVdescA += SZ2->Z2_VLRDR
        
        
        cOutDsAN+=SZ2->Z2_OUTDESP
        
		// Guardando Valor da Descarga
		IF SZ2->Z2_DESCT <> 0
			cDescar := SZ2->Z2_DESCT
		ENDIF
		// Guardando valor do Custo
		IF SZ2->Z2_OUTCUST <> 0
			cOuCust := SZ2->Z2_OUTCUST
		ENDIF



		IF SZ2->Z2_VLRBR <> 0
			cVboniR := SZ2->Z2_VLRBR
		ENDIF
		SZ2->(DbSkip())
	ENDDO

	// cVdescA := cVdesc - cVdescA
	cVlrBoA := cVboniR-cVlrBoA

	IF cVdesc > 0
		IF  lDesc =.T.
			if cVdescA <> 0
				cVdescA := cVdesc - cVdescA
			else
				cVdescA := cVdesc
				cVdescAC := 0
				//           IF lDesc = .T.
				//           if cVdescA  = 0
				lSimDe := .T.
				//         endif
				//         ENDIF
			endif
		ELSE
			cVdescA := cVdesc
		ENDIF
	ENDIF

     IF cOutDesp > 0
        IF lOdes  = .T.
           IF cOutDsAN<>0
              cOutDesp:= cOutDesp-cOutDsAN
              cOutDsAN:= cOutDesp 
           ELSE
              cOutDsAN:= cOutDesp 
           ENDIF
        ELSE
            cOutDsAN:= cOutDesp
        ENDIF       
     ENDIF


	oListBox2:SetArray(aListBox2)

	oListBox2:bLine := {|| {;
	IIF(aListBox2[oListBox2:nAT,01] = 'OK',oVerde,IIF(aListBox2[oListBox2:nAT,01] = 'BL',oVerme,oBranc)),;//aListBox2[oListBox2:nAT,01],;
	aListBox2[oListBox2:nAT,02],;
	aListBox2[oListBox2:nAT,03],;
	aListBox2[oListBox2:nAT,04],;
	aListBox2[oListBox2:nAT,05]}}


	oListBox2:Refresh()


return .t.


STATIC FUNCTION Vmargem(Mest2,Mmin,Mmax,Mest,Cc,CF,PISC,CONFC,ICM,ICMD,CRe,PISD,CONFD,cMarPr3,cAut)
	cBloque:= ''
	cReviso:= ''
	If (SB0->B0_PARATA + SB0->B0_PARPR3) < 10 .AND. DATE() - SB0->B0_DTALTAT > 90 .and. nQtdAt > 2 .AND. nQtdAt >= SB0->B0_QTD2
		cBloque+="|D" // bloqueio por quantidade minima de participação de atacado na venda

	EndIf



	cSuMk3:= 0
	cSuPr3:= 0
	cSuPrVa:= 0
	cSuMkVa:= 0
	cSuMkAt:= 0
	cSuPrAt:= 0


	nGdAli:= ICMD

	ICMD:= ICMD - cCrdPre

	Mest2:=Mest2/100
	//Mmin:=Mmin/100
	//Mmax:=Mmax/100
	Mmin:=Mest2
	Mmax:=Mest2
	Mest:=Mest/100
	PISC:=PISC/100
	CONFC:=CONFC/100
	PISD:=PISD/100
	CONFD:=CONFD/100
	ICM:=ICM/100
	ICMD:=ICMD/100
	CIND:=GETMV("MV_CUSTIND")/100
	cPerTran := GETMV("MV_PERTRAN")/100





	If SD1->D1_CLASFIS = '040'
		ICM  := 0
		ICMD := 0
	EndIf

	//if  mMarEAL <> cmarest
	IF Mest2<Mmin
		Alert("Margem Menor que a Minima "+STR(Mmin*100,5,2))
		cMarEst2 := Mest
		RETURN .F.
	ENDIF

	IF Mest2>Mmax
		Alert("Margem Maior que a Maxima "+STR(Mmax*100,5,2))
		cMarEst2 := Mest
		RETURN .F.
	ENDIF
	//endif

	// P -  cVenLiq = preço de venda
	// M -  Mest2 = margem
	// F - CC     = Custo Fabrica
	// R - CF     = Custo fabrica + Frete
	// D - Cre     = custo reposição
	// X - PISC    = Aliquota PIS CREDITO
	// Y - CONFC   = Aliquota Cofins CREDITO
	// t - PISD    = Aliquota PIS DEBIT
	// w - CONFD   = Aliquota Cofins DEBITO

	// A - ICM    = aliquota ICMS credito
	// Z - ICMD   = aliquota icms debito


	nIdTra:= nIdTra/100

	If nIdTra = 0
		InTraProd(SZ2->Z2_PROD)
	EndIf

	If nIdTra > 0.08
		InTraFab(SB1->B1_FABR)
	Endif

	If  nIdTra > 0.08
		InTraEst(SZ2->Z2_PROD)
	EndIf



	// CALCULA PRECO DE VAREJO
	cPerV1:= cMarEst2V/100

	cMrPar:= cPerV1 // margem parametro para calculo
	cMrgCal:= 0 // margem calculada entre preco de venda e custo final
	nVlrAju:= 0
	lOk:= .f.
	WHILE lOk = .f.

		// Calculo do Preco Varejo

		cVenLV :=   (( ( 1/(1 - cPerV1))*cre  ) - (  ( 1/(1 - cPerV1))*((cf-(cVboni/cVquant))*pisc)  ) - (  ( 1/(1 - cPerV1))*((cf-(cVboni/cVquant))*confc)  ) - (  ( 1/(1 - cPerV1))*(cc*icm) ) ) /  (1 - ( ( 1/(1 - cPerV1))*pisd)   -   ((1/(1 - cPerV1))*confd)   -   ((1/(1 - cPerV1))*icmd) - ((1/(1 - cPerV1))*CIND) - ((1/(1 - cPerV1))*nIdTra) )


		cCuFinalV:= Cre + (cVenLV*PISC) - ((cf-(cVboni/cVquant))*PISD) + (cVenLV*CONFC) - ((cf-(cVboni/cVquant))*CONFD) + (cVenLV*ICMD) - (CC *ICM) + (cVenLV*CIND) + (cVenLV*nIdTra)

		cMrgCal:= ((round(cVenLV,2) - round(cCuFinalV,2))/ round(cVenLV,2))

		If cMrPar > cMrgCal
			nVlrAju:= 0.001
			cPerV1+= nVlrAju
		Else
			lOk:= .t.
		EndIf

	Enddo
	cPerV1:= cMrPar

	cVenLV:= Round(cVenLV,2)
	cVarVlr := TRANSFORM(cVenLV ,"@E 999,999.99")

	cUltDig:= substr(cVarVlr,Len(cVarVlr),1)
	If cUltDig = "0"
		cVenLV-= 0.01
	ElseIf cUltDig = "9"

	ElseIf cUltDig = "8"
		cVenLV+= 0.01
	Else
		cVenLV+= 0.02
	Endif

	// verifica se o custo baixo conforme paramentro estipulado no cadastro de subsecao tabela ZAW
	If 1-(cCustoFa2/ cCuAntF) > 0 .and.  1-(cCustoFa2/ cCuAntF) <= nPerManPr .and. cVenLV <= cVAvar .and.  lMantPr = .T.

		cVenLV := cVAvar

		cPerV1 := ( cVenLV - (Cre + (cVenLV*PISD) - ((cf-(cVboni/cVquant)) * PISC) + (cVenLV*CONFD) - ((cf-(cVboni/cVquant))*CONFC) + (cVenLV*ICMD) - (CC*ICM) + (cVenLV*CIND) + (cVenLV*nIdTra) ) ) / cVenLV

		cCuFinalV:= Cre + (cVenLV*PISC) - ((cf-(cVboni/cVquant))*PISD) + (cVenLV*CONFC) - ((cf-(cVboni/cVquant))*CONFD) + (cVenLV*ICMD) - (CC *ICM) + (cVenLV*CIND) + (cVenLV*nIdTra)
		//cPerV := cPerV1


	EndIf

	cVarVlr := TRANSFORM(Round(cVenLV,2) ,"@E 999,999.99")

	cIndTrV:= cVenLV * nIdTra



	cICMTRIV := (cVenLV*ICMD) - (CC *ICM)
	cCOFINSV := (cVenLV*CONFC) - ((cf-(cVboni/cVquant))*CONFD)
	cPISV := (cVenLV*PISC) - ((cf-(cVboni/cVquant))*PISD)

	cVenLAN:= round(cVenLiq,2)

	// verifica se a entrega de rentabilidade em R$ de cada unidade esta abaixo de 80% da media da categoria, se estiver calcula sugestão
	If round((cVenLV - cCuFinalV),2) < round((cRenMed * 0.90),2)

		cBloque+="|A" // A rentabilidade liquida menor que 80% da rentabilidade media da categoria por unidade

		cVlrLuc:= cRenMed * 0.90

		cSuPrVa = (cVlrLuc + Cre - ((cf-(cVboni/cVquant)) * PISC) - ((cf-(cVboni/cVquant))*CONFC) - (CC*ICM))/(1 - (PISD + ICMD + CIND + nIdTra + CONFD))

		cSuMkVa:= round((cVlrLuc/cSuPrVa*100),2)

	Endif



	// CALCULA PRECO DE ATACADO FRACIONADO


	cMrPar:= Mest2 // margem parametro para calculo
	cMrgCal:= 0 // margem calculada entre preco de venda e custo final
	nVlrAju:= 0
	lOk:= .f.
	WHILE lOk = .f.



		// inserido calculo abaixo com indece de transferencia
		cVenLiq :=   (( ( 1/(1 - Mest2))*cre  ) - (  ( 1/(1 - Mest2))*((cf-(cVboni/cVquant))*pisc)  ) - (  ( 1/(1 - Mest2))*((cf-(cVboni/cVquant))*confc)  ) - (  ( 1/(1 - Mest2))*(cc*icm) ) ) /  (1 - ( ( 1/(1 - Mest2))*pisd)   -   ((1/(1 - Mest2))*confd)   -   ((1/(1 - Mest2))*icmd) - ((1/(1 - Mest2))*CIND) - ((1/(1 - Mest2))*nIdTra) )


		cCuFinal:= Cre + (cVenLiq*PISC) - ((cf-(cVboni/cVquant))*PISD) + (cVenLiq*CONFC) - ((cf-(cVboni/cVquant))*CONFD) + (cVenLiq*ICMD) - (CC *ICM) + (cVenLiq*CIND) + (cVenLiq*nIdTra)

		cMrgCal:= ((round(cVenLiq,2) - round(cCuFinal,2))/ round(cVenLiq,2))

		If cMrPar > cMrgCal
			nVlrAju:= 0.001
			Mest2+= nVlrAju
		Else
			lOk:= .t.
		EndIf

	Enddo
	Mest2:= cMrPar

	cVenLiq:= Round(cVenLiq,2)
	cVarVlr := TRANSFORM(cVenLiq ,"@E 999,999.99")


	cUltDig:= substr(cVarVlr,Len(cVarVlr),1)
	If cUltDig = "0"
		cVenLiq-= 0.01
	ElseIf cUltDig = "9"

	ElseIf cUltDig = "8"
		cVenLiq+= 0.01
	Else
		cVenLiq+= 0.02
	Endif

	// verifica se o custo baixo conforme paramentro estipulado no cadastro de subsecao tabela ZAW
	If 1-(cCustoFa2/ cCuAntF) > 0 .and.  1-(cCustoFa2/ cCuAntF) <= nPerManPr .and. cVenLiq <= cVAtac  .and.  lMantPr = .t.

		cVenLiq := cVAtac

		Mest2 := ( cVenLiq - (Cre + (cVenLiq*PISD) - ((cf-(cVboni/cVquant)) * PISC) + (cVenLiq*CONFD) - ((cf-(cVboni/cVquant))*CONFC) + (cVenLiq*ICMD) - (CC*ICM) + (cVenLiq*CIND) + (cVenLiq*nIdTra) ) ) / cVenLiq

		cCuFinal:= Cre + (cVenLiq*PISC) - ((cf-(cVboni/cVquant))*PISD) + (cVenLiq*CONFC) - ((cf-(cVboni/cVquant))*CONFD) + (cVenLiq*ICMD) - (CC *ICM) + (cVenLiq*CIND) + (cVenLiq*nIdTra)


	EndIf

	cIndTrA:= cVenLiq * nIdTra

	cICMTRI := (cVenLiq*ICMD) - (CC *ICM)
	cCOFINS := (cVenLiq*CONFC) - ((cf-(cVboni/cVquant))*CONFD)
	cPIS    := (cVenLiq*PISC) - ((cf-(cVboni/cVquant))*PISD)


	// calcula relacao MKP Qtd minima atacado
	//nx:= 2
	cSuMkAt:= cPerV1
	aCalc:= {}
	For n:=1 To (nQtdAt)
		If n = 1
			aadd(aCalc,{ cPerV1, 0 })
		Else
			aadd(aCalc,{ 0, ((((1+cPerV1)^1)/n)-(1/n)) })
			nTem:= 0
			For nx:=1 to Len(aCalc)
				If Len(aCalc) = nx
					aCalc[nx,1] := (nTem + aCalc[nx,2])/n
					cSuMkAt:= aCalc[nx,1]
				Else
					nTem+= aCalc[nx,1]
				EndIf

			Next
		EndIf

	Next


	cSuPrAt :=   (( ( 1/(1 - cSuMkAt))*cre  ) - (  ( 1/(1 - cSuMkAt))*((cf-(cVboni/cVquant))*pisc)  ) - (  ( 1/(1 - cSuMkAt))*((cf-(cVboni/cVquant))*confc)  ) - (  ( 1/(1 - cSuMkAt))*(cc*icm) ) ) /  (1 - ( ( 1/(1 - cSuMkAt))*pisd)   -   ((1/(1 - cSuMkAt))*confd)   -   ((1/(1 - cSuMkAt))*icmd) - ((1/(1 - cSuMkAt))*CIND) - ((1/(1 - cSuMkAt))*nIdTra) )

	cSuMkAt:= round(cSuMkAt*100,2)



	If round(cVenLiq,2) < round(cSuPrAt,2)
		cBloque+="|B" // A rentabilidade liquida quando o produto atinge a quantidade minima de atacado e menor que 110% a relabilidade do varejo.
	EndIf


	// calcula preco de venda de atacado volume

	cMarPr3:= cMarPr3/100

	cMrPar:= cMarPr3 // margem parametro para calculo
	cMrgCal:= 0 // margem calculada entre preco de venda e custo final
	nVlrAju:= 0
	lOk:= .f.
	WHILE lOk = .f.


		cVenPR3 :=   (( ( 1/(1 - cMarPr3))*cre  ) - (  ( 1/(1 - cMarPr3))*((cf-(cVboni/cVquant))*pisc)  ) - (  ( 1/(1 - cMarPr3))*((cf-(cVboni/cVquant))*confc)  ) - (  ( 1/(1 - cMarPr3))*(cc*icm) ) ) /  (1 - ( ( 1/(1 - cMarPr3))*pisd)   -   ((1/(1 - cMarPr3))*confd)   -   ((1/(1 - cMarPr3))*icmd) - ((1/(1 - cMarPr3))*CIND) - ((1/(1 - cMarPr3))*nIdTra) )



		cCuFinalP3 := Cre + (cVenPR3*PISC) - ((cf-(cVboni/cVquant))*PISD) + (cVenPR3*CONFC) - ((cf-(cVboni/cVquant))*CONFD) + (cVenPR3*ICMD) - (CC *ICM) + (cVenPR3*CIND) + (cVenPR3*nIdTra)

		cMrgCal:= ((round(cVenPR3,2) - round(cCuFinalP3,2))/ round(cVenPR3,2))

		If cMrPar > cMrgCal
			nVlrAju:= 0.001
			cMarPr3+= nVlrAju
		Else
			lOk:= .t.
		EndIf

	Enddo

	// verifica se o custo baixo conforme paramentro estipulado no cadastro de subsecao tabela ZAW
	If 1-(cCustoFa2/ cCuAntF) > 0 .and.  1-(cCustoFa2/ cCuAntF) <= nPerManPr .and. cVenPR3 <= cVAPR3  .and.  lMantPr = .t.

		cVenPR3 := cVAPR3

		cMarPr3 := ( cVenPR3 - (Cre + (cVenPR3*PISD) - ((cf-(cVboni/cVquant)) * PISC) + (cVenPR3*CONFD) - ((cf-(cVboni/cVquant))*CONFC) + (cVenPR3*ICMD) - (CC*ICM) + (cVenPR3*CIND) + (cVenPR3*nIdTra) ) ) / cVenPR3

		cCuFinalP3:= Cre + (cVenPR3*PISC) - ((cf-(cVboni/cVquant))*PISD) + (cVenPR3*CONFC) - ((cf-(cVboni/cVquant))*CONFD) + (cVenPR3*ICMD) - (CC *ICM) + (cVenPR3*CIND) + (cVenPR3*nIdTra)

	EndIf


	cCuRepo3:= cCuRepo

	cICMtriP3 := (cVenPR3*ICMD) - (CC *ICM)
	cCOFINSP3 := (cVenPR3*CONFC) - ((cf-(cVboni/cVquant))*CONFD)
	cPISP3    := (cVenPR3*PISC) - ((cf-(cVboni/cVquant))*PISD)

    // Modificado Jorge porque valores estavam vindo negativo
       IF cICMtriP3<0
          cICMtriP3:= 0
       ENDIF

       IF cCOFINSP3<0
          cCOFINSP3:= 0
       ENDIF

       IF cPISP3 < 0
          cPISP3 := 0
       ENDIF


    //








	cIndTrP3:= cVenPR3 * nIdTra


	// calcula relacao MKP Qtd minima atacado
	nnX:= round((nQtdPr/nQtdAt),0)
	cSuMk3:= Mest2
	aCalc:= {}

	For n:=1 To nnX
		If n = 1
			aadd(aCalc,{ Mest2, 0 })
			If nnX = 1
				cSuMk3:= Mest2
			EndIf
		Else
			aadd(aCalc,{ 0, ((((1+Mest2)^1)/n)-(1/n)) })
			nTem:= 0
			For nx:=1 to Len(aCalc)
				If Len(aCalc) = nx
					aCalc[nx,1] := (nTem + aCalc[nx,2])/n
					cSuMk3:= aCalc[nx,1]
				Else
					nTem+= aCalc[nx,1]
				EndIf

			Next
		EndIf

	Next


	cSuPr3 :=   (( ( 1/(1 - cSuMk3))*cre  ) - (  ( 1/(1 - cSuMk3))*((cf-(cVboni/cVquant))*pisc)  ) - (  ( 1/(1 - cSuMk3))*((cf-(cVboni/cVquant))*confc)  ) - (  ( 1/(1 - cSuMk3))*(cc*icm) ) ) /  (1 - ( ( 1/(1 - cSuMk3))*pisd)   -   ((1/(1 - cSuMk3))*confd)   -   ((1/(1 - cSuMk3))*icmd) - ((1/(1 - cSuMk3))*CIND) - ((1/(1 - cSuMk3))*nIdTra) )

	cSuMk3:= round(cSuMk3*100,2)


	If round(cVenPR3,2) < round(cSuPr3,2)
		cBloque+="|C" // A rentabilidade liquida quando o produto atinge a quantidade minima do preco 3 e menor que 110% a relabilidade quando atinge a quantidade minima do atacado.
	EndIf



	//cMarEst2 :=
	//Calcula custo de transferencia

	cPrTran :=  (( ( 1/(1 - cPerTran))*cre  ) - (  ( 1/(1 - cPerTran))*((cf-(cVboni/cVquant))*0)  ) - (  ( 1/(1 - cPerTran))*((cf-(cVboni/cVquant))*0)  ) - (  ( 1/(1 - cPerTran))*(cc*icm) ) ) /  (1 - ( ( 1/(1 - cPerTran))*0)   -   ((1/(1 - cPerTran))*0)   -   ((1/(1 - cPerTran))*icmd) - ((1/(1 - cPerTran))*0) )

	nIdTra:= Round(nIdTra*100,6)
	ICMD:= nGdAli

	cMarEst2V:= round(cPerV1*100,2)

	cMarEst2:= round(Mest2*100,2)

	cMarPr3:= round(cMarPr3*100,2)


	If cAut = .f.
		If "A" $ cBloque
			cReviso+='* Rentabilidade no varejo menor que rentabilidade média da categoria!'  + Chr(13) + Chr(10)
			oVenLV:setcss(cBgAtec)
		Else
			oVenLV:setcss(cBgNorm)
		EndIf

		If "B" $ cBloque
			cReviso+='* Rentabilidade atacado menor que o esperado!'  + Chr(13) + Chr(10)
			oVenLiq:setcss(cBgAtec)
		Else
			oVenLiq:setcss(cBgNorm)
		EndIf

		If "C" $ cBloque
			cReviso+='* Rentabilidade preço 3 menor que o esperado!'  + Chr(13) + Chr(10)
			oVenPR3:setcss(cBgAtec)
		Else
			oVenPR3:setcss(cBgNorm)
		EndIf

		If "D" $ cBloque
			cReviso+='* Participação atacado menor que o esperado!'  + Chr(13) + Chr(10)
			oQtdAt:setcss(cBgAtec)
		Else
			oQtdAt:setcss(cBgNorm)
		EndIf
	Endif
Return .t.


STATIC FUNCTION VpreV(Mest2,Mmin,Mmax,Mest,Cc,CF,PISC,CONFC,ICM,ICMD,CRe,PISD,CONFD,PVENA)

	//mMarEAL:= val(str(Mest2,12,2))
	mMarEAL:= round(Mest2,2)

	mvendar:= pvena

	//mMarEAL:= Mest2

	Mest2:=Mest2/100
	Mmin:=Mmin/100
	Mmax:=Mmax/100
	Mest:=Mest/100
	PISC:=PISC/100
	CONFC:=CONFC/100
	PISD:=PISD/100
	CONFD:=CONFD/100
	ICM:=ICM/100
	ICMD:=ICMD/100
	CIND:=GETMV("MV_CUSTIND")/100

	If SD1->D1_CLASFIS = '040'
		ICM  := 0
		ICMD := 0
	EndIf


	//P = preço de venda                         M = margem             F = Custo Fabrica               R= Custo fabrica + Frete                 D = custo reposição
	//X = Aliquota PIS credito               Y = Aliquota Cofins credito       T = Aliquota PIS debito         W = Aliquota cofins debito
	//A = aliquota ICMS credito          Z = aliquota icms debito
	//Formula digita preço de venda calcula margem


	// P -  PVENA = preço de venda
	// M -  Mest2 = margem
	// F - CC     = Custo Fabrica
	// R - CF     = Custo fabrica + Frete
	// D - Cre     = custo reposição
	// X - PISC    = Aliquota PIS CREDITO
	// Y - CONFC   = Aliquota Cofins CREDITO
	// t - PISD    = Aliquota PIS DEBIT
	// w - CONFD   = Aliquota Cofins DEBITO

	// A - ICM    = aliquota ICMS credito
	// Z - ICMD   = aliquota icms debito


	Mest2 := ( PVENA - (Cre + (PVENA*CIND) + (PVENA*PISD) - ((cf-(cVboni/cVquant)) * PISC) + (PVENA*CONFD) - ((cf-(cVboni/cVquant))*CONFC) + (PVENA*ICMD) - (CC*ICM)) ) / PVENA

	cCuFinal:= Cre + (PVENA*PISC) - ((cf-(cVboni/cVquant))*PISD) + (PVENA*CONFC) - ((cf-(cVboni/cVquant))*CONFD) + (PVENA*ICMD) - (CC *ICM) + (PVENA*CIND)


	cICMTRI := (PVENA*ICMD) - (CC *ICM)
	cCOFINS := (PVENA*CONFC) - ((cf-(cVboni/cVquant))*CONFD)
	cPIS := (PVENA*PISC) - ((cf-(cVboni/cVquant))*PISD)


	if cPreSug <> 0
		@ C(048),C(305) Say "Preço Definido Pelo Comprador" Size C(0140),C(008) COLOR CLR_RED PIXEL OF oDlgP
	endif


	//IF mMarEAL <> CMAREST
	//IF Mest2<Mmin
	/*// inicio retirado pelo cristian
	IF cVenLAN <> PVENA

	IF mMarEAL <cMarMin


	//IF mMarEAL < Mmin

	if cPreSug = 0
	//      alert(mMareal)
	Alert("Margem Menor que a Minima "+STR(Mmin*100,5,2))
	//      cMarEst2 := Mest
	cMarEst2:= cMarEst
	RETURN .F.
	else
	@ C(055),C(305) Say "Margem Menor que a Minima "+STR(Mmin*100,5,2) Size C(0140),C(008) COLOR CLR_RED PIXEL OF oDlgP
	endif


	ENDIF

	//IF Mest2>Mmax

	//IF mMarEAL > Mmax
	IF mMarEAL > cMarMax
	if cPreSug = 0
	//      alert(mMarEAL)
	//     alert(cMarMax)
	//    alert(mvendar)

	Alert("Margem Maior que a Maxima "+STR(Mmax*100,5,2))
	//      cMarEst2 := Mest
	cMarEst2:= cMarEst
	RETURN .F.
	else
	@ C(055),C(305) Say "Margem Maior que a Maxima "+STR(Mmin*100,5,2) Size C(0140),C(008) COLOR CLR_RED PIXEL OF oDlgP
	endif
	ENDIF

	ENDIF

	fim do retirado pelo cristian*/



	cMarEst2 := Mest2*100


	// Calculo do Varejo

	cVenLV := (PVENA*cPerV)/100
	cVenLV := PVENA+cVenLV

	cMarEst2V := ( cVenLV - (Cre + (cVenLV*PISD) - ((cf-(cVboni/cVquant)) * PISC) + (cVenLV*CONFD) - ((cf-(cVboni/cVquant))*CONFC) + (cVenLV*ICMD) - (CC*ICM)) ) / cVenLV

	cICMTRIV := (cVenLV*ICMD) - (CC *ICM)
	cCOFINSV := (cVenLV*CONFC) - ((cf-(cVboni/cVquant))*CONFD)
	cPISV := (cVenLV*PISC) - ((cf-(cVboni/cVquant))*PISD)

	cCuFinalV:= Cre + (cVenLV*PISC) - ((cf-(cVboni/cVquant))*PISD) + (cVenLV*CONFC) - ((cf-(cVboni/cVquant))*CONFD) + (cVenLV*ICMD) - (CC *ICM)


	cMarEst2V := cMarEst2V*100



Return .t.

// Legendas de Precificação
USER FUNCTION LegPre()

	BRWLEGENDA("Precificação de Preço","Legenda",;
	{{"BR_VERDE"     ,"Produto Não Precificado"},;
	{"BR_VERMELHO" ,"Produto Já Precificado"}})
return(.t.)

USER FUNCTION Legpreite()

	BRWLEGENDA("Precificação de Preço","Legenda",;
	{{"BR_BRANCO"     ,"Produto Não Precificado"},;
	{"BR_VERMELHO"     ,"Produto bloqueado"},;
	{"BR_VERDE" ,"Produto Já Precificado"}})
return(.t.)

//  Rotina para Visualizar Precificação

USER FUNCTION ViEspp()

	Private nVlrPed := 0
	Private cVAPR3  := 0
	Private cCrdPre := 0
	Private cNota := SPACE(9)
	Private cFornece := SPACE(6)
	Private cSerie  := SPACE(3)
	Private cLoja   := SPACE(2)
	Private cFreteEX  := 0
	Private oFreteEX  := 0
	Private cEmissao
	Private cFrete  :=0
	Private oFrete := 0
	Private cDescar:= 0          // Descarga
	Private cSegCar:= 0          // Seguro de Carga
	Private cOuCust:= 0          // Outros Custos
	Private oOuCust
	Private cDesPed
	Private cPedOBS
	Private cVlrBrut
	Private cPedido
	Private cVTotal
	Private cUTotal
	Private cVquant
	Private cPreSug
	Private cMarEst2
	Private oMarEst2
	Private cMarEst        //Margem Estipulada
	Private cMarMin        //Margem Minima
	Private cMarMax        //Margem Maxima
	Private cEst
	Private cGrTrib
	Private cPPisC
	Private cPPisD
	Private cPCONFD
	Private cPCONFC
	Private cICMST
	Private cICMVST
	Private cVAtac
	Private cVAvar
	Private cAicmD
	Private cPrefixo := SPACE(3)
	Private cNumTit:= SPACE(9)
	Private cForDesc := SPACE(6)
	Private cLoDes := SPACE(2)
	Private cVdescR := 0
	Private cICMTRI
	Private cCOFINS
	Private cPIS
	Private cPerV
	Private cPISV := 0
	Private cCOFINSV := 0
	Private cICMtriV := 0
	Private cCuFinalV := 0
	Private cMarEst2V := 0
	Private cVenLV := 0
	Private cPrTran := 0
	Private cVpref := .f.
	Private cVlrBoni := 0
	Private cVlrBoA := 0
	Private cCGC8
	Private cVboni :=  0
	Private cVboniA := 0
	Private cVdescA := 0
	Private cVenLAN
	Private cVdesc:=0
	Private cCuRepo3  := 0
	Private cPISP3  := 0
	Private cCOFINSP3 := 0
	Private cICMtriP3 := 0
	Private cCuFinalP3 := 0
	Private cMarEst2P3 := 0
	Private cVenPR3 := 0
	//Private cVAPR3 := 0
	Private vMarPr3 := 0
	// Variaveis Private da Funcao
	Private _oDlg				// Dialog Principal
	Private _oDlgN
	// Variaveis que definem a Acao do Formulario
	Private VISUAL := .F.
	Private INCLUI := .F.
	Private ALTERA := .F.
	Private DELETA := .F.
	// Privates das ListBoxes
	Private aListBox1 := {}
	Private aListBox2 := {}
	Private oListBox1
	Private oListBox2
	Private _aNota:= {}
	Private cCusAnt
	Private cCusAnR
	Private cCusAnF
	Private lSim	 := .F.
	Private lSimDe   := .F.
	Private oSimDe
	Private lSimOd   := .F.
	Private oSimOd
	Private oSim
	Private lBoni:= .F. // FLAG PARA CONTROLAR BONIFICACAO, CAMPO RATEADO QUANDO JA FOI PRECIFICADO
	Private lDesc:= .F. // FLAG PARA CONTROLAR DESCONTO, CAMPO RATEADO QUANDO JA FOI PRECIFICADO
	Private lOdes:= .F. // FLAG PARA CONTROLAR OUTRAS DESPESAS, CAMPO RATEADO QUANDO JA FOI PRECIFICADO
	Private cVboniR := 0
	Private cVbonSa := 0
	Private cVdesU  := 0
	Private cVdescAC :=0
	Private cDDesU   := 0
	Private cEstoq1
	Private cCuMedia
	Private cVqmedia
	Private cCalM1
	Private cCalM2
	Private cCuRepo2
	Private cRepos2
	Private cOutDesp
	Private cOutDsAN
	Private cOutDsUs:= 0
	Private cOutDECo:= 0
	Private cOuDavu := 0    // Variavel para despesas avulsas exemplo: PING e Vasilhame
	//Private nVlrPed := 0
	Private cIndTrP3 := 0
	Private cIndTrV := 0
	Private cIndTrA := 0
	//Private cCrdPre := 0
	Private nPerManPr := 0
	Private cSuMk3:= 0
	Private cSuPr3:= 0
	Private cSuPrVa:= 0
	Private cSuMkVa:= 0
	Private cSuMkAt:= 0
	Private cSuPrAt:= 0
	Private cRenMed:= 0
	Private cBloque:= ""
	Private nQtdAt:= 0
	Private nQtdPr:= 0
	Private cIdUsuario := retcodusr()
	Private lGerent := .f.
	Private cReviso :=''
	Private oReviso
	Private oVenLV
	Private oVenLiq
	Private oVenPR3
	Private oQtdAt
	Private lVisuali:= .t.

	IF SZ2->Z2_FLAG  <> "OK"
		Alert("Produto Não Precificado Verifique !")
		RETURN
	ENDIF

	cIndTrA:= 0
	cIndTrV:= 0
	cIndTrP3:= 0

	cVdescA := 0
	cVlrBoA := 0
	cOutDsUS:= 0
	cOutDsAN:= 0
	nVlrPed := 0

	cCustoFa2 := SZ2->Z2_CUSTOFA
	cCustoFa  := SZ2->Z2_CFABM
	cVICMST :=  SZ2->Z2_VICMST
	cIPI :=  SZ2->Z2_IPI
	cRdesc := SZ2->Z2_DESCR
	cRfrete := SZ2->Z2_FRETER
	cRsegCa := SZ2->Z2_SEGUR
	cRoutCus := SZ2->Z2_OUTCUSR
	cVAtac := SZ2->Z2_VAATAC
	cVAvar := SZ2->Z2_VAVAR
	cCuRepo := SZ2->Z2_CUSTORE
	cCuRepo3 := SZ2->Z2_CREPM
	cPIS  := SZ2->Z2_PIS
	cCOFINS := SZ2->Z2_COFINS
	cICMtri := SZ2->Z2_ICMTRI
	cCuFinal := SZ2->Z2_CUFINAL
	cMarEst2 := SZ2->Z2_MAREST
	cVenLiq := SZ2->Z2_VENLIQ
	cCuRepo2 := SZ2->Z2_CUSTORE
	cCuRepo := SZ2->Z2_CREPM
	cPISV   := SZ2->Z2_PISV
	cCOFINSV := SZ2->Z2_COFINSV
	cICMtriV := SZ2->Z2_ICMTRIV
	cCuFinalV := SZ2->Z2_CUFINAV
	cMarEst2V := SZ2->Z2_MARESTV
	cVenLV    := SZ2->Z2_VENLV
	cPPisC    := SZ2->Z2_PISC
	cPCONFC   := SZ2->Z2_COFINSC
	cPPisD    := SZ2->Z2_PISD
	cPCONFD   := SZ2->Z2_COFINSD
	cIcmst    := SZ2->Z2_ICMCRED
	cAicmD    := SZ2->Z2_ICMDEB
	cVboni    := SZ2->Z2_VLRBON
	cCuAntF   := SZ2->Z2_CANFAB
	cPicmsC   := SZ2->Z2_PICMSC
	cAicmD    := SZ2->Z2_ICMDEB
	cVboni    := SZ2->Z2_VLRBR
	cVdesU    := SZ2->Z2_VLRDR
	cPISP3	  := SZ2->Z2_PR3PIS
	cCOFINSP3 := SZ2->Z2_PR3COF
	cICMtriP3 := SZ2->Z2_PR3ICMT
	cCuFinalP3:= SZ2->Z2_PR3CFIN
	vMarPr3	  := SZ2->Z2_PR3MKP
	cVenPR3   := SZ2->Z2_PR3
	cProd:= SZ2->Z2_PROD
	cCrdPre := SZ2->Z2_CRPRES


	nIdTra:= SZ2->Z2_INDF/100

	cIndTrA:= cVenLiq * nIdTra
	cIndTrV:= cVenLV * nIdTra
	cIndTrP3:= cVenPR3 * nIdTra
	cVdesU := SZ2->Z2_VLRDR
	cVboni := SZ2->Z2_VLRBON

	cNomep:= POSICIONE("SB1",1,xFilial("SB1")+cProd,"B1_DESC")

	DbSelectArea("SB0")
	DbSetOrder(1)
	DbSeek(SZ2->Z2_FILIAL+SZ2->Z2_PROD)

	nQtdAt:= SB0->B0_QTD2
	nQtdPr:= SB0->B0_QTDPR3


	DbSelectArea("SF1")
	DbSetOrder(1)
	DbSeek(SZ2->Z2_FILIAL+SZ2->Z2_DOC+SZ2->Z2_SERIE+SZ2->Z2_FORNECE+SZ2->Z2_LOJA)

	DbSelectArea("SD1")
	DbSetOrder(1)
	DbSeek(SZ2->Z2_FILIAL+SZ2->Z2_DOC+SZ2->Z2_SERIE+SZ2->Z2_FORNECE+SZ2->Z2_LOJA+SZ2->Z2_PROD)

	cOutDsUS := SD1->D1_DESPESA

	dbSelectArea("SC7")
	dbSetOrder(2)
	Dbseek(xFilial("SC7")+SZ2->Z2_PROD+SZ2->Z2_FORNECE+SZ2->Z2_LOJA+SD1->D1_PEDXML)
	if found()
		nVlrPed:= SC7->C7_PRECO
	endif


	_cQuery:=" SELECT SUM(Z2_VLRDR) AS VLR"
	_cQuery+=" FROM SZ2010"
	_cQuery+=" WHERE Z2_FILIAL = '"+SZ2->Z2_FILIAL+"'"
	_cQuery+=" AND   Z2_DOC = '"+SZ2->Z2_DOC+"'"
	_cQuery+=" AND   Z2_SERIE = '"+SZ2->Z2_SERIE+"'"
	_cQuery+=" AND   Z2_FORNECE = '"+SZ2->Z2_FORNECE+"'"
	_cQuery+=" AND   SZ2010.D_E_L_E_T_ = ''"
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),"TMP2",.T.,.T.)

	cVdescA := TMP2->VLR


	TMP2->(DbCloseArea())

	_cQuery:=" SELECT SUM(Z2_VLRBON) AS VLR "
	_cQuery+=" FROM SZ2010"
	_cQuery+=" WHERE Z2_FILIAL = '"+SZ2->Z2_FILIAL+"'"
	_cQuery+=" AND   Z2_DOC = '"+SZ2->Z2_DOC+"'"
	_cQuery+=" AND   Z2_SERIE = '"+SZ2->Z2_SERIE+"'"
	_cQuery+=" AND   Z2_FORNECE = '"+SZ2->Z2_FORNECE+"'"
	_cQuery+=" AND   SZ2010.D_E_L_E_T_ = ''"
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),"TMP2",.T.,.T.)

	cVlrBoA:= TMP2->VLR

	TMP2->(DbCloseArea())

	lSaiE :=.F.


	cVlrff:= 1
	cEst:= SF1->F1_EST
	cDescr:= cProd+" "+cNomeP
	cNCM:= SB1->B1_POSIPI
	cTpOper:= SD1->D1_CF+' - '+POSICIONE("SX5",1,SD1->D1_FILIAL+'13'+SD1->D1_CF,"X5_DESCRI")

	DEFINE MSDIALOG oDlgv TITLE cProd+" "+cNomeP FROM C(10000),C(175) TO C(10350),C(1190) PIXEL

	//DEFINE MSDIALOG oDlgv TITLE cProd+" "+cNomeP FROM C(10000),C(175) TO C(10350),C(1170) PIXEL
	// botoes
	@ C(066),C(465) Button "Analise Venda" Size C(037),C(012) PIXEL OF oDlgv Action (AnalVen(),lSai:= .f.)
	@ C(080),C(465) Button "Divergencia Ped." Size C(037),C(012) PIXEL OF oDlgv Action (U_DESPNOT(),lSai:= .f.)
	@ C(108),C(465) Button "Historico" Size C(037),C(012) PIXEL OF oDlgv Action HisPre(cProd)
	@ C(122),C(465) Button "Conhecimento" Size C(037),C(012) PIXEL OF oDlgv Action MsDocument( "SF1", SF1->( Recno() ), 1 )
	@ C(150),C(465) Button "Sair" Size C(037),C(012) PIXEL OF oDlgv Action oDlgv:END()

	// Custo Anterior de Fabrica
	@ C(001),C(007) Say "Custo Anterior" Size C(065),C(008) COLOR CLR_BLACK PIXEL OF oDlgv
	@ C(007),C(007) MsGet cCuAntF  PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgv WHEN cVlrff = 0

	@ C(001),C(050) Say "Preço Pedido" Size C(065),C(008) COLOR CLR_BLACK PIXEL OF oDlgv
	@ C(007),C(050) MsGet nVlrPed  PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgv WHEN cCustoFa = 0

	@ C(001),C(093) Say "Produto" Size C(121),C(008) COLOR CLR_BLACK PIXEL OF oDlgv
	@ C(007),C(093) MsGet cDescr  PICTURE "@! " Size C(164),C(009) COLOR CLR_BLACK PIXEL OF oDlgv WHEN cVlrff = 0

	@ C(001),C(265) Say "Estado" Size C(065),C(008) COLOR CLR_BLACK PIXEL OF oDlgv
	@ C(007),C(265) MsGet cEst  PICTURE "@!" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgv WHEN cVlrff = 0

	@ C(001),C(305) Say "NCM" Size C(065),C(008) COLOR CLR_BLACK PIXEL OF oDlgv
	@ C(007),C(305) MsGet cNCM  PICTURE "@!" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgv WHEN cVlrff = 0

	@ C(001),C(345) Say "Tipo Operacao" Size C(072),C(008) COLOR CLR_BLACK PIXEL OF oDlgv
	@ C(007),C(345) MsGet cTpOper  PICTURE "@!" Size C(115),C(009) COLOR CLR_BLACK PIXEL OF oDlgv WHEN cVlrff = 0

	@ C(001),C(468)  Say "% Cust Transf" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oDlgv
	@ C(007),C(468) MsGet nIdTra PICTURE "@E 999,999.9999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgv WHEN cVlrff = 0

	@ C(018),C(007) Say "Fabrica" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgv
	@ C(018),C(050) Say "Fabrica Media" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgv

	@ C(018),C(093) Say "ICM ST" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF oDlgv
	@ C(018),C(136) Say "IPI" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF oDlgv
	@ C(018),C(179) Say "Descarga" Size C(055),C(008) COLOR CLR_BLACK PIXEL OF oDlgv
	@ C(018),C(222) Say "Frete" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF oDlgv
	@ C(018),C(265) Say "Seguro Carga" Size C(055),C(008) COLOR CLR_BLACK PIXEL OF oDlgv
	@ C(018),C(305) Say "Outros Custos" Size C(055),C(008) COLOR CLR_BLACK PIXEL OF oDlgv


	@ C(018),C(345)  Say "Desconto Usado" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oDlgv
	@ C(018),C(385)  Say "Desconto Total" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oDlgv

	@ C(018),C(425)  Say "Valor Bonificado" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oDlgv
	@ C(018),C(468)  Say "Bonificação" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oDlgv
	@ C(001),C(468)  Say "% Cust Transf" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oDlgv

	// Outras Despesas
	@ C(037),C(425)  Say "Valor Despesas" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oDlgv
	@ C(037),C(468)  Say "Outras Despesas" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oDlgv



	@ C(025),C(007) MsGet cCustoFa2 PICTURE "@E 999,999.99" Size C(035),C(009) COLOR  CLR_RED PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(025),C(050) MsGet cCustoFa PICTURE "@E 999,999.99" Size C(035),C(009) COLOR  CLR_RED PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(025),C(093) MsGet cVICMST PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(025),C(136) MsGet cIPI PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(025),C(179) MsGet cRdesc PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(025),C(222) MsGet cRfrete PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(025),C(265) MsGet cRsegCa PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(025),C(305) MsGet cRoutCus PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgv WHEN cVlrff = 0



	@ C(025),C(345) MsGet cVdesU PICTURE  "@E 999,999.9999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(025),C(385) MsGet cVdescA PICTURE "@E 999,999.9999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgv WHEN cVlrff = 0

	@ C(025),C(425) MsGet cVboni PICTURE "@E 999,999.9999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgv   WHEN cVlrff = 0
	@ C(025),C(468) MsGet cVlrBoA PICTURE "@E 999,999.9999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgv WHEN cVlrff = 0

	// Outras Despesas
	@ C(043),C(425) MsGet cOutDsUS PICTURE "@E 999,999.9999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(043),C(468) MsGet cOutDsAN PICTURE "@E 999,999.9999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgv WHEN cVlrff = 0

	@ C(037),C(007) Say "Reposição" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgv
	@ C(043),C(007) MsGet cCuRepo2 PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgv WHEN cVlrff = 0


	@ C(037),C(339)  Say "Qtd Min Atac" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oDlgv
	@ C(037),C(382)  Say "Qtd Min Preço 3" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oDlgv
	@ C(043),C(339) MsGet nQtdAt PICTURE "@E 999,999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgv when cVlrff = 0
	@ C(043),C(382) MsGet nQtdPr PICTURE "@E 999,999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgv when cVlrff = 0

	// Preço VAREJO
	@ 069 , 002 GROUP oGroup2 TO 107, 590 PROMPT "Composicao de custos do preço de Varejo" OF oDlgv COLOR 0, 16777215 PIXEL
	@ C(060),C(050) Say "Reposição Médio" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgv
	@ C(060),C(093) Say "PIS" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF oDlgv
	@ C(060),C(136) Say "COFINS" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF oDlgv
	@ C(060),C(179) Say "ICMS Tributado" Size C(055),C(008) COLOR CLR_BLACK PIXEL OF oDlgv
	@ C(060),C(222) Say "Custo Transfer." Size C(035),C(008) COLOR CLR_RED PIXEL OF oDlgv
	@ C(060),C(265) Say "Custo Final" Size C(025),C(008) COLOR CLR_RED PIXEL OF oDlgv
	@ C(060),C(305) Say "Margem Liquida" Size C(055),C(008) COLOR CLR_BLUE PIXEL OF oDlgv
	@ C(060),C(345) Say "Preço de Varejo" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgv
	@ C(060),C(385) Say "Tabela Anterior" Size C(065),C(008) COLOR CLR_BLACK PIXEL OF oDlgv

	@ C(067),C(050) MsGet cCuRepo PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(067),C(093) MsGet cPISV PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(067),C(136) MsGet cCOFINSV PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(067),C(179) MsGet cICMtriV PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(067),C(222) MsGet cIndTrV PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(067),C(265) MsGet cCuFinalV PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(067),C(305) MsGet cMarEst2V PICTURE "@E 9,999.99" Size C(035),C(009)  COLOR CLR_BLUE PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(067),C(345) MsGet cVenLV PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgv  WHEN cVlrff = 0
	@ C(067),C(385) MsGet cVAvar PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgv WHEN cVlrff = 0



	// Preço ATACADO
	@ 108, 002 GROUP oGroup1 TO 146, 590 PROMPT "Composicao de custos do preço de Atacado" OF oDlgv COLOR 0, 16777215 PIXEL

	@ C(090),C(050) Say "Reposição Média" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgv
	@ C(090),C(093) Say "PIS" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF oDlgv
	@ C(090),C(136) Say "COFINS" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF oDlgv
	@ C(090),C(179) Say "ICMS Tributado" Size C(055),C(008) COLOR CLR_BLACK PIXEL OF oDlgv
	@ C(090),C(222) Say "Custo Transfer." Size C(035),C(008) COLOR CLR_RED PIXEL OF oDlgv
	@ C(090),C(265) Say "Custo Final" Size C(025),C(008) COLOR CLR_RED PIXEL OF oDlgv
	@ C(090),C(305) Say "Margem Liquida" Size C(055),C(008) COLOR CLR_BLUE PIXEL OF oDlgv
	@ C(090),C(345) Say "Preço de Atacado" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgv
	@ C(090),C(385) Say "Tabela Anterior" Size C(065),C(008) COLOR CLR_BLACK PIXEL OF oDlgv


	@ C(097),C(050) MsGet cCuRepo PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(097),C(093) MsGet cPIS PICTURE "@E 999,999.9999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(097),C(136) MsGet cCOFINS PICTURE "@E 999,999.9999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(097),C(179) MsGet cICMtri PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(097),C(222) MsGet cIndTrA PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(097),C(265) MsGet cCuFinal PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(097),C(305) MsGet cMarEst2 PICTURE "@E 9,999.99" Size C(035),C(009)  COLOR CLR_BLUE PIXEL OF oDlgv  WHEN cVlrff = 0 //VALID Vmargem(cMarEst2,cMarMin,cMarMax,cMarEst,cCustoFa,cCustoFa+cRfrete,cPPisC,cPCONFC,cPicmsC,cAicmD,cCuRepo,cPPisD,cPCONFD,vMarPr3) WHEN cPreSug = 0
	@ C(097),C(345) MsGet cVenLiq PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgv  WHEN cVlrff = 0
	@ C(097),C(385) MsGet cVAtac PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgv WHEN cVlrff = 0
	//@ C(048),C(308) MsGet cVenLiq PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP  VALID    VpreV(cMarEst2,cMarMin,cMarMax,cMarEst,cCustoFa,cCustoFa+cRfrete,cPPisC,cPCONFC,cPicmsC,cAicmD,cCuRepo,cPPisD,cPCONFD,cVenLiq) WHEN cPreSug = 0





	// COMPOOSICAO PRECO 3

	@ 147 , 002 GROUP oGroup2 TO 180, 590 PROMPT "Composicao de custos do preço Atacado Volume" OF oDlgv COLOR 0, 16777215 PIXEL
	@ C(120),C(050) Say "Reposição Média" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgv
	@ C(120),C(093) Say "PIS" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF oDlgv
	@ C(120),C(136) Say "COFINS" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF oDlgv
	@ C(120),C(179) Say "ICMS Tributado" Size C(055),C(008) COLOR CLR_BLACK PIXEL OF oDlgv
	@ C(120),C(222) Say "Custo Transfer." Size C(035),C(008) COLOR CLR_RED PIXEL OF oDlgv
	@ C(120),C(265) Say "Custo Final" Size C(025),C(008) COLOR CLR_RED PIXEL OF oDlgv
	@ C(120),C(305) Say "Margem Liquida" Size C(055),C(008) COLOR CLR_BLUE PIXEL OF oDlgv
	@ C(120),C(345) Say "Preço Atac 3" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgv
	@ C(120),C(385) Say "Tabela Anterior" Size C(065),C(008) COLOR CLR_BLACK PIXEL OF oDlgv

	@ C(127),C(050) MsGet cCuRepo3 PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(127),C(093) MsGet cPISP3 PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(127),C(136) MsGet cCOFINSP3 PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(127),C(179) MsGet cICMtriP3 PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgv WHEN cVlrff = 0

	@ C(127),C(222) MsGet cIndTrP3 PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(127),C(265) MsGet cCuFinalP3 PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(127),C(305) MsGet vMarPr3 PICTURE "@E 9,999.99" Size C(035),C(009)  COLOR CLR_BLUE PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(127),C(345) MsGet cVenPR3 PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgv  WHEN cVlrff = 0
	@ C(127),C(385) MsGet cVAPR3 PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgv WHEN cVlrff = 0







	// Aliquotas

	//@ C(135),C(007) Say "Aliquotas" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP
	@ 182, 002 GROUP oGroup2 TO 220, 500 PROMPT "Aliquotas" OF oDlgv COLOR 0, 16777215 PIXEL
	@ C(148),C(007) Say "PIS Credito" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgv
	@ C(148),C(050) Say "COFINS Credito" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgv
	@ C(148),C(093) Say "PIS Debito" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgv
	@ C(148),C(136) Say "CONFIS Debito" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgv
	@ C(148),C(179) Say "ICM Credito" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgv
	@ C(148),C(222) Say "ICM Debito" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgv
	@ C(148),C(265) Say "ICM Cr Presumido" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgv

	@ C(155),C(007) MsGet cPPisC  PICTURE "@E 999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(155),C(050) MsGet cPCONFC  PICTURE "@E 999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(155),C(093) MsGet cPPisD  PICTURE "@E 999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(155),C(136) MsGet cPCONFD PICTURE "@E 999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(155),C(179) MsGet cPicmsC PICTURE "@E 999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(155),C(222) MsGet cAicmD PICTURE "@E 999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgv WHEN cVlrff = 0
	@ C(155),C(265) MsGet cCrdPre PICTURE "@E 999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgv WHEN cVlrff = 0






	ACTIVATE MSDIALOG oDlgv CENTERED


RETURN

// fim da Vizualização





// EXCLUSÃO  de Precificação

USER FUNCTION CaEspp()


	cVlrBrut:= Z2_VALMERC
	cFrete  := Z2_FRETET
	cSegcar := Z2_SEGUT
	cNota  := Z2_DOC
	cSerie := Z2_SERIE
	cFornece := Z2_FORNECE
	cLoja := Z2_LOJA
	cDescar := Z2_DESCT
	cOuCust := Z2_OUTCUST
	cPrefixo:= Z2_PREFIXO
	cNumTit:= Z2_NUMTIT
	cForDes:= Z2_FORDES
	cLojDes:= Z2_LOJDES
	cVboni := Z2_VLRBON
	cEmissao := Z2_EMISSAO
	cCGC8:= POSICIONE("SA2",1,xFilial("SA2")+cFornece+cLoja,"LEFT(A2_CGC,8)")

	lSai:=.f.
	aListBox2:= {}

	dbSelectArea("SZ2")
	dbSetOrder(1)
	Dbseek(xFilial("SB0")+cNota+cSerie+cFornece+cLoja)

	DO WHILE SZ2->Z2_DOC = cNota .AND. SZ2->Z2_SERIE = cSerie .AND. SZ2->Z2_FORNECE = cFornece   .AND. SZ2->Z2_LOJA = cLoja .AND. !SZ2->(Eof())
		aadd(aListBox2,{SZ2->Z2_FLAG,SZ2->Z2_PROD,POSICIONE("SB1",1,xFilial("SB1")+SZ2->Z2_PROD,"B1_DESC"),TRANS(SZ2->Z2_QUANT,"@E 99999,999"),TRANS(SZ2->Z2_VUNIT,"@E 99999,99") })
		SZ2->(DbSkip())
	ENDDO


	DEFINE MSDIALOG _oDlgC TITLE "Cancelamento de Precificação de Produto" FROM C(00),C(174) TO C(250),C(960) PIXEL

	@ C(008),C(007)  Say "Fornecedor" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF _oDlgC
	@ C(008),C(050)  Say "Loja" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF _oDlgC
	@ C(008),C(080)  Say "Nota Fiscal" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF _oDlgC
	@ C(008),C(118)  Say "Serie" Size C(023),C(008) COLOR CLR_BLACK PIXEL OF _oDlgC
	@ C(008),C(157)  Say "Frete" Size C(030),C(008) COLOR CLR_BLACK PIXEL OF _oDlgC
	@ C(008),C(202)  Say "Descarga" Size C(030),C(008) COLOR CLR_BLACK PIXEL OF _oDlgC
	@ C(008),C(247)  Say "Seguro carga" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF _oDlgC
	@ C(008),C(292)  Say "Outros Custos" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF _oDlgC

	@ C(018),C(007) MsGet cFornece F3 "SA2"   Size C(030),C(009) COLOR CLR_BLACK PIXEL OF _oDlgC  WHEN cFornece = SPACE(6)
	@ C(018),C(050) MsGet cLoja     Size C(015),C(009) COLOR CLR_BLACK PIXEL OF _oDlgC WHEN cFornece = SPACE(6)
	@ C(018),C(080) MsGet cNota PICTURE "@!" Size C(025),C(009) COLOR CLR_BLACK PIXEL OF _oDlgC WHEN cFornece = SPACE(6)
	@ C(018),C(118) MsGet cSerie Size C(015),C(009) COLOR CLR_BLACK PIXEL OF _oDlgC  WHEN cFornece = SPACE(6)


	@ C(018),C(157) MsGet oFrete VAR cFrete PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF _oDlgC WHEN cFornece = SPACE(6)
	@ C(018),C(202) MsGet cDescar PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF _oDlgC WHEN cFornece = SPACE(6)
	@ C(018),C(247) MsGet cSegcar PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF _oDlgC WHEN cFornece = SPACE(6)

	@ C(018),C(292) MsGet cOuCust PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF _oDlgC WHEN cFornece = SPACE(6)


	@ C(40),C(007) ListBox oListBox2 Fields ;
	HEADER "Status","Produto","Nome","Quantidade","Preco";
	Size C(274),C(048) Of _oDlgc Pixel;
	ColSizes 20,50,100,70,70

	oListBox2:Refresh(aListBox2)
	oListBox2:SetArray(aListBox2)


	// Carrege aqui sua array da Listbox


	oListBox2:bLine := {|| {;
	IIF(aListBox2[oListBox2:nAT,01] = 'OK',oVerde,IIF(aListBox2[oListBox2:nAT,01] = 'BL',oVerme,oBranc)),;//aListBox2[oListBox2:nAT,01],;
	aListBox2[oListBox2:nAT,02],;
	aListBox2[oListBox2:nAT,03],;
	aListBox2[oListBox2:nAT,04],;
	aListBox2[oListBox2:nAT,05]}}



	@ C(90),C(024) Button "Confirma" Size C(037),C(012) PIXEL OF _oDlgC Action(_oDlgC:END(),lSai:=.T.)
	@ C(90),C(070) Button "Sair" Size C(037),C(012) PIXEL OF _oDlgC Action _oDlgC:END()

	ACTIVATE MSDIALOG _oDlgC CENTERED


	IF lSai

		dbSelectArea("SZ2")
		dbSetOrder(1)
		Dbseek(xFilial("SB0")+cNota+cSerie+cFornece+cLoja)



		DO WHILE SZ2->Z2_DOC = cNota .AND. SZ2->Z2_SERIE = cSerie .AND. SZ2->Z2_FORNECE = cFornece   .AND. SZ2->Z2_LOJA = cLoja .AND. !SZ2->(Eof())
		/*	IF Z2_FLAG <> 'OK'
				dbskip()
				LOOP
			ENDIF
        */
			lFam:= .F.
			cFamil:= POSICIONE("SB1",1,xFilial("SB1")+SZ2->Z2_PROD,"B1_CFAM")
			DbSelectArea("SZ1")
			DbSetOrder(1)
			DbSeek(xFilial("SZ1")+SB1->B1_CFAM)


			IF cFamil<>SPACE(2) .AND. SZ1->Z1_PADPREC = 'S'
				lFam:= .T.
			EndIf
			cItens:=''
			IF lFam

				// Coloca no array as familia do produto
				Private oDlgfa
				Private oOk  := LoadBitMap(GetResources(), "LBOK")
				Private oNo  := LoadBitMap(GetResources(), "LBNO")
				Private aArFam:= {}
				Private oArFam


				dbSelectArea("SB1")
				SB1->(DbOrderNickName("FAMILIA"))
				dbseek(xFilial("SB1")+cFamil)
				mSeqf:=0
				DO WHILE SB1->B1_CFAM = cFamil  .AND. !SB1->(Eof())
					aadd(aArFam,{' ',SB1->B1_COD,SB1->B1_DESC,SB1->B1_UM})
					mSeqf++
					dbskip()

				ENDDO

				IF mSeqf = 0
					MsgInfo("Não Existe Produto com Esta Familia")
					return .t.
				ENDIF



				oOk  := LoadBitMap(GetResources(), "LBOK")
				oNo  := LoadBitMap(GetResources(), "LBNO")


				DEFINE MSDIALOG _oDlgfa TITLE OemToAnsi("Escolha os Produtos Referente a Familia") FROM C(0),C(0) To C(200),C(700) PIXEL OF oMainWnd //17
				oFont  := TFont():New("Courier New",0,14,,.f.,,,,.f.,.f.)

				oArFam := TWBrowse():New( c(10),c(5),c(340),c(075),,{" ","Produto","Descrição","Unidade"},,_oDlgfa,,,,,,,,,,,,.F.,,.T.,,.F.,,,)

				oArFam:SetArray(aArFam)
				oArFam:bLine := {|| { iif(aArFam[oArFam:nAt,1]="*",oOk,oNo), aArFam[oArFam:nAt,2] ,aArFam[oArFam:nAt,3],aArFam[oArFam:nAt,4]}}

				oArFam:bLDBLCLICK := {|| aArFam[oArFam:nAt,1] := IIF(aArFam[oArFam:nAt,1] = '*',' ','*'),oArFam:refresh() }

				_lOk := .f.

				@ C(088),C(220) Button "Confirma os Produtos"           Size C(80),C(10) Action  _oDlgfa:End()    pixel of _oDlgfa

				Activate Dialog _oDlgfa CENTERED
				cItens:=""
				For n:=1 To Len(aArFam)
					If Empty(cItens)
						cItens+= "'"+aArFam[n,2]+"'"
					Else
						cItens+= ",'"+aArFam[n,2]+"'"
					EndIf
				Next

			EndIf
			If Empty(cItens)
				cItens:= "'"+SZ2->Z2_PROD+"'"
			EndIf




			// Atualizando Preços de ATACADO e VAREJO LOJA
			cProd := SZ2->Z2_PROD
			lFam := SZ2->Z2_FAM
			cVarejo:= SZ2->Z2_VAVAR
			cVataca:= SZ2->Z2_VAATAC
			cPr3:= SZ2->Z2_PR3
			cFamil:= POSICIONE("SB1",1,xFilial("SB1")+cProd,"B1_CFAM")
			cVenLiq := SZ2->Z2_VENLIQ
			cVboni  := SZ2->Z2_VLRBON
			cCusAnt := SZ2->Z2_CUSANT
			cCuRepo := SZ2->Z2_CREPMAT
			cCustCont := SZ2->Z2_CCONANT

			IF SZ2->Z2_FLAG = 'OK'
				csql:=" UPDATE SB0010 SET B0_PRV1 = "+cValToChar(round(cVarejo,2))+"  "
				csql+="                  ,B0_PRV2 = "+cValToChar(round(cVataca,2))+"  "
				csql+="                  ,B0_PRV6 = "+cValToChar(round(cPr3,2))+"  "
				csql+="                  ,B0_ALTERA = '"+Dtos(DATE())+"'  "
				csql+=" WHERE B0_FILIAL = '"+xFilial("SZ2")+"'"
				csql+=" AND   B0_COD IN("+cItens+")"

				If (TCSQLExec(csql) < 0)
					Return MsgStop("TCSQLError() " + TCSQLError())
				Else

				EndIf


				csql:=" UPDATE SB2010 SET    B2_CFAB    = "+cValToChar(cCusAnt)+" "
				csql+=" 					,B2_CREPM   = "+cValToChar(cCuRepo)+" "
				csql+=" 					,B2_CCONT   = "+cValToChar(cCustCont)+" "
				csql+=" WHERE B2_FILIAL = '"+xFilial("SZ2")+"'"
				csql+=" AND   B2_COD  IN("+cItens+")"

				If (TCSQLExec(csql) < 0)
					Return MsgStop("TCSQLError() " + TCSQLError())
				Else

				EndIf
			EndIf

			csql:=" UPDATE SZ2010 SET D_E_L_E_T_ = '*'"
			csql+=" WHERE Z2_FILIAL = '"+xFilial("SZ2")+"'"
			csql+=" AND   Z2_DOC = '"+cNota+"'"
			csql+=" AND   Z2_SERIE = '"+cSerie+"'"
			csql+=" AND   Z2_FORNECE = '"+cFornece+"'"
			csql+=" AND   Z2_PROD IN("+cItens+")"
			csql+=" AND   SZ2010.D_E_L_E_T_ = ''"

			If (TCSQLExec(csql) < 0)
				Return MsgStop("TCSQLError() " + TCSQLError())
			Else

			EndIf


			// Atualizando Bonificação

			IF cVboni <> 0

				dbSelectArea("SZB")
				RecLock('SZB',.T.)
				SZB->ZB_FILIAL  := xFilial("SD1")
				SZB->ZB_FORNECE := cFornece
				SZB->ZB_LOJA    := cLoja
				SZB->ZB_NOTA    := cNota
				SZB->ZB_SERIE   := cSerie
				SZB->ZB_VALOR   := cVboni
				SZB->ZB_DATA    := Date()
				SZB->ZB_TIPO    := "C"
				SZB->ZB_EMISSAO := cEmissao
				SZB->ZB_CGC     := cCGC8
				SZB->ZB_OBSERV := "CANCELAMENTO PRECIFICACAO"
				SZB->ZB_TPMOV   := '1'
				SZB->ZB_ORIG    := 'PRECO'
				SZB->ZB_USUAR   := Alltrim(cUserName)
				SZB->(MsUnlock())

				//  Soma na Bonificacao
				dbSelectArea("SZC")
				dbSetOrder(2)
				dBseek(xFilial("SZC")+cFornece)

				IF FOUND()
					RecLock('SZC',.F.)
					SZC->ZC_SALDO += cVboni
					SZC->ZC_ULTDATA := Date()
					SZC->(MsUnlock())
				ENDIF

			ENDIF

			//
			dbSelectArea("SZ2")
			SZ2->(DbSkip())
		ENDDO

		//endif

		//  Atualizando TABELA de PRECIFICAÇÃO

		// Fim da Rotina

		// Liberando a NOTA para nova Precificação
		dbSelectArea("SF1")
		dbSetOrder(1)
		Dbseek(xFilial("SF1")+cNota+cSerie+cFornece+cLoja)
		RecLock("SF1",.F.)
		SF1->F1_PREFIC  := " "
		SF1->(MsUnLock())
		//

		// Liberando a Descargar no Contas a Pagar caso tenha Descarga
		IF cPrefixo <> SPACE(3)
			dbSelectArea("SE2")
			dbSetOrder(6)
			Dbseek(xFilial("SE2")+cForDes+cLojDes+cPrefixo+cNumTit)
			RecLock("SE2",.F.)
			SE2->E2_NOTADES  := SPACE(9)
			SE2->(MsUnLock())
		ENDIF

	endif
	///



RETURN

// Fim da Rotina de Cancelamento


// Procura nota Descarga

STATIC FUNCTION FbuDes()

	aDesc := {}
	dbSelectArea("SE2")
	dbSetOrder(2)
	cNaturez:= "03.001.001"
	Dbseek(xFilial("SE2")+cNaturez)

	IF FOUND()
		mSeq := 0
		DO WHILE SE2->E2_FILIAL = xFilial("SE2") .AND. SE2->E2_NATUREZ = cNaturez .AND. !SE2->(Eof())
			IF SE2->E2_NOTADES <> " "// <> SPACE(9)  // Codigo especifico para Despesas da DESCARGA
				SE2->(DbSkip())
				LOOP
			ENDIF


			aadd(aDesc,{' ',SE2->E2_FORNECE,SE2->E2_LOJA,SE2->E2_PREFIXO,SE2->E2_NUM,SE2->E2_EMISSAO,SE2->E2_VENCTO,TRANS(SE2->E2_VALOR,"@E 999,999.99"),SE2->E2_HIST})
			mSeq++
			SE2->(DbSkip())
		ENDDO
		IF mSeq = 0
			MsgInfo("Não Existe Despesas registrada Para Esse Natureza")
			return .t.
		ENDIF

	ELSE
		MsgInfo("Não Existe Despesas registrada Para Esse Natureza")
		return .t.
	ENDIF


	Private oOk  := LoadBitMap(GetResources(), "LBOK")
	Private oNo  := LoadBitMap(GetResources(), "LBNO")

	DEFINE MSDIALOG _oDlgDf TITLE OemToAnsi("Escolha as Descarga Referente a Nota") FROM C(0),C(0) To C(200),C(700) PIXEL OF oMainWnd //17
	oFont  := TFont():New("Courier New",0,14,,.f.,,,,.f.,.f.)

	_oDesc := TWBrowse():New( c(10),c(5),c(340),c(075),,{" ","Fornecedor","Loja","Prefixo","Documento","Emissão","Vencimento","Valor","Historico"},,_oDlgDf,,,,,,,,,,,,.F.,,.T.,,.F.,,,)

	_oDesc:SetArray(aDesc)
	_oDesc:bLine := {|| { iif(aDesc[_oDesc:nAt,1]="*",oOk,oNo), aDesc[_oDesc:nAt,2] ,aDesc[_oDesc:nAt,3],aDesc[_oDesc:nAt,4],aDesc[_oDesc:nAt,5],aDesc[_oDesc:nAt,6],aDesc[_oDesc:nAt,7],aDesc[_oDesc:nAt,8],aDesc[_oDesc:nAt,9]}}

	_oDesc:bLDBLCLICK := {|| aDesc[_oDesc:nAt,1] := IIF(aDesc[_oDesc:nAt,1] = '*',' ','*'), _oDesc:refresh() }

	_lOk := .f.

	@ C(088),C(220) Button "Confirma as Descarga"           Size C(80),C(10) Action _oDlgDf:End() pixel of _oDlgDf

	Activate Dialog _oDlgDf CENTERED


	nCnot:= 0

	for _nI := 1 to len(aDesc)
		if aDesc[_nI,1] = '*'
			nCnot++
			cDescar := VAL(aDesc[_nI,8])
			cPrefixo:=aDesc[_nI,4]
			cNumTit := aDesc[_nI,5]
			cForDesc:= aDesc[_nI,2]
			cLoDes := aDesc[_nI,3]
		endif
	next


	IF nCnot = 0
		MsgInfo("Nenhuma Descarga selecionado")
		return .t.
	ENDIF


	IF nCnot > 1
		MsgInfo("Selecione Apenas Uma Despesas de Descarga")
		return .f.
	ENDIF

RETURN .T.


// Rotina para Outros Custos

STATIC FUNCTION FbuOutc()

	aoUtcus := {}
	dbSelectArea("SE2")
	dbSetOrder(2)
	cNaturez:= "03.001.002"
	Dbseek(xFilial("SE2")+cNaturez)

	IF FOUND()
		mSeq := 0
		DO WHILE SE2->E2_FILIAL = xFilial("SE2") .AND. SE2->E2_NATUREZ = cNaturez .AND. !SE2->(Eof())
			IF SE2->E2_NOTAOUC <> SPACE(9)  // Codigo especifico para Despesas de OUTROS CUSTOS
				SE2->(DbSkip())
				LOOP
			ENDIF

			aadd(aoUtcus,{' ',SE2->E2_FORNECE,SE2->E2_LOJA,SE2->E2_PREFIXO,SE2->E2_NUM,SE2->E2_EMISSAO,SE2->E2_VENCTO,TRANS(SE2->E2_VALOR,"@E 999,999.99"),SE2->E2_HIST})
			mSeq++
			SE2->(DbSkip())
		ENDDO
		IF mSeq = 0
			MsgInfo("Não Existe Despesas Registrada Para Esse Natureza")
			return .t.
		ENDIF

	ELSE
		MsgInfo("Não Existe Despesas registrada Para Esse Natureza")
		return .t.
	ENDIF


	Private oOk  := LoadBitMap(GetResources(), "LBOK")
	Private oNo  := LoadBitMap(GetResources(), "LBNO")

	DEFINE MSDIALOG _oDlgDf TITLE OemToAnsi("Escolha Outros Custo Referente a Nota") FROM C(0),C(0) To C(200),C(700) PIXEL OF oMainWnd //17
	oFont  := TFont():New("Courier New",0,14,,.f.,,,,.f.,.f.)

	_ooUtcus := TWBrowse():New( c(10),c(5),c(340),c(075),,{" ","Fornecedor","Loja","Prefixo","Documento","Emissão","Vencimento","Valor","Historico" },,_oDlgDf,,,,,,,,,,,,.F.,,.T.,,.F.,,,)

	_ooUtcus:SetArray(aoUtcus)
	_ooUtcus:bLine := {|| { iif(aoUtcus[_ooUtcus:nAt,1]="*",oOk,oNo), aoUtcus[_ooUtcus:nAt,2] ,aoUtcus[_ooUtcus:nAt,3],aoUtcus[_ooUtcus:nAt,4],aoUtcus[_ooUtcus:nAt,5],aoUtcus[_ooUtcus:nAt,6],aoUtcus[_ooUtcus:nAt,7],aoUtcus[_ooUtcus:nAt,8],aoUtcus[_ooUtcus:nAt,9]}}

	_ooUtcus:bLDBLCLICK := {|| aoUtcus[_ooUtcus:nAt,1] := IIF(aoUtcus[_ooUtcus:nAt,1] = '*',' ','*'),_ooUtcus:refresh() }

	_lOk := .f.

	@ C(088),C(220) Button "Confirma Outros Custos"           Size C(80),C(10) Action _oDlgDf:End() pixel of _oDlgDf

	Activate Dialog _oDlgDf CENTERED


	nCnot:= 0

	for _nI := 1 to len(aoUtcus)
		if aoUtcus[_nI,1] = '*'
			nCnot++
			cOuCust := VAL(aoUtcus[_nI,8])
			cPrefixo:=aoUtcus[_nI,4]
			cNumTit :=aoUtcus[_nI,5]
			cForDesc:=aoUtcus[_nI,2]
			cLoDes :=aoUtcus[_nI,3]
		endif
	next


	IF nCnot = 0
		MsgInfo("Nenhum Outros Custos selecionado")
		return .t.
	ENDIF


	IF nCnot > 1
		MsgInfo("Selecione Apenas Uma Despesas de Outros de Custos")
		return .f.
	ENDIF

RETURN .T.


STATIC function fdboni(vbo,prodc)

	if lSim = .f.

		//IF vbo>cVlrboA
		//   alert("Valor Maior Que Saldo")
		//  return .f.
		//endif

		IF vbo = 0
			alert("Existe Saldo de Bonificação")
			return .t.
		endif



		cVlrboA := cVlrboA-vbo
		cCuRepo2 := cRepos2-(vbo/cVquant)




		// Calculando a Reposição do Preço Medio

		//  Mudando a Variavel do Custo de Reposição para custo de reposição Médio

		//  cCuRepo2:= cCustoFa2 + cVICMST + cIPI + cRdesc + cRfrete +cRsegCa +cRoutCus
		//  cRepos2 := cCuRepo2


		cEstoq1  := POSICIONE("SB2",2,xFilial("SB2")+"01"+prodc,"B2_QATU")
		cCuRMed  := POSICIONE("SB2",2,xFilial("SB2")+"01"+prodc,"B2_CREPM")
		cCuFMed  := POSICIONE("SB2",2,xFilial("SB2")+"01"+prodc,"B2_CFABM")

		_cQuery:=" SELECT D1_QUANT "
		_cQuery+=" FROM SD1010"
		_cQuery+=" WHERE D1_FILIAL = '"+SD1->D1_FILIAL+"' "
		_cQuery+=" AND   D1_COD = '"+SD1->D1_COD+"' "
		_cQuery+=" AND   SUBSTRING(D1_TES,3,1) = '7' "
		_cQuery+=" AND   D1_DTDIGIT = '"+DTOS(SD1->D1_DTDIGIT)+"' "
		_cQuery+=" AND   D_E_L_E_T_ = ''	"
		dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),"TMP2",.T.,.T.)

		If Empty(TMP2->D1_QUANT)

		Else
			cEstoq1:= cEstoq1 - TMP2->D1_QUANT
		Endif

		TMP2->(DBCLOSEAREA())

		cVqmedia := cEstoq1 - cVquant

		IF cVqmedia < 0
			cVqmedia := 0
		ENDIF

		If cCuRMed = 0
			cCuRMed := cCuRepo2
			cCuFMed := cCustoFa2
			cVqmedia := cVquant
		EndIf

		cCalRM1 := cCuRMed * cVqmedia
		cCalRM2 := cCuRepo2 * cVquant

		//   cCalFM1 := cCuFMed * cVqmedia
		//   cCalFM2 := cCustoFa2 * cVquant



		cCuRepo :=  (cCalRM1 +cCalRM2) / (cVqmedia+cVquant)
		cRepos  := cCuRepo

		//   cCustoFa :=  (cCalFM1+cCalFM2) / (cVqmedia+cVquant)



	else

		//IF cVboniA>cVlrboA
		//  alert("Valor Maior Que Saldo")
		//  return .f.
		//endif

		IF cVboniA = 0
			alert("Existe Saldo de Bonificação")
			return .t.
		endif



		cVlrboA := cVlrboA-cVboniA
		cCuRepo2 := cRepos2-(cVboniA/cVquant)

		cVboni := cVboniA


		// Calculando a Reposição do Preço Medio

		//  Mudando a Variavel do Custo de Reposição para custo de reposição Médio

		//  cCuRepo2:= cCustoFa2 + cVICMST + cIPI + cRdesc + cRfrete +cRsegCa +cRoutCus
		//  cRepos2 := cCuRepo2


		cEstoq1  := POSICIONE("SB2",2,xFilial("SB2")+"01"+prodc,"B2_QATU")
		cCuRMed  := POSICIONE("SB2",2,xFilial("SB2")+"01"+prodc,"B2_CREPM")
		cCuFMed  := POSICIONE("SB2",2,xFilial("SB2")+"01"+prodc,"B2_CFABM")

		cVqmedia := cEstoq1 - cVquant

		IF cVqmedia < 0
			cVqmedia := 0
		ENDIF

		cCalRM1 := cCuRMed * cVqmedia
		cCalRM2 := cCuRepo2 * cVquant

		//   cCalFM1 := cCuFMed * cVqmedia
		//   cCalFM2 := cCustoFa2 * cVquant



		cCuRepo :=  (cCalRM1 +cCalRM2) / (cVqmedia+cVquant)
		cRepos  := cCuRepo

		//   cCustoFa :=  (cCalFM1+cCalFM2) / (cVqmedia+cVquant)



		//


	endif



return .t.



STATIC function fdbonG(vbg)

	IF vbg>cVlrBoni
		alert("Valor Maior Que Saldo")
		return .f.
	endif

	IF vbg = 0
		alert("Existe Saldo de Bonificação")
		return .t.
	endif


	cVlrBoni:=cVlrBoni-vbg

return .t.


static function CalDe(DesU,cprod)

	if DesU > cVdescA
		alert("Valor Maior que o Restante do Desconto, Verifique !")
		return .f.
	endif

	//cPercD:= (DesU/cVlrBrut)*100
	cPercD:= DesU/cVquant


	cCustoFa2 := cCustoFa2-cPercD



	///////////////
	cCuRepo2:= cCustoFa2 + cVICMST + cIPI + cRdesc + cRfrete +cRsegCa +cRoutCus
	cRepos2 := cCuRepo2


	cEstoq1  := POSICIONE("SB2",2,xFilial("SB2")+"01"+cProd,"B2_QATU")
	cCuRMed := POSICIONE("SB2",2,xFilial("SB2")+"01"+cProd,"B2_CREPM")
	cCuFMed := POSICIONE("SB2",2,xFilial("SB2")+"01"+cProd,"B2_CFABM")

	_cQuery:=" SELECT D1_QUANT "
	_cQuery+=" FROM SD1010"
	_cQuery+=" WHERE D1_FILIAL = '"+SD1->D1_FILIAL+"' "
	_cQuery+=" AND   D1_COD = '"+SD1->D1_COD+"' "
	_cQuery+=" AND   SUBSTRING(D1_TES,3,1) = '7' "
	_cQuery+=" AND   D1_DTDIGIT = '"+DTOS(SD1->D1_DTDIGIT)+"' "
	_cQuery+=" AND   D_E_L_E_T_ = ''	"
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),"TMP2",.T.,.T.)

	If Empty(TMP2->D1_QUANT)

	Else
		cEstoq1:= cEstoq1 - TMP2->D1_QUANT
	Endif

	TMP2->(DBCLOSEAREA())

	cVqmedia := cEstoq1 - cVquant

	IF cVqmedia < 0
		cVqmedia := 0
	ENDIF

	cCalRM1 := cCuRMed * cVqmedia
	cCalRM2 := cCuRepo2 * cVquant

	cCalFM1 := cCuFMed * cVqmedia
	cCalFM2 := cCustoFa2 * cVquant



	cCuRepo :=  (cCalRM1 +cCalRM2) / (cVqmedia+cVquant)
	cRepos  := cCuRepo

	cCustoFa :=  (cCalFM1+cCalFM2) / (cVqmedia+cVquant)




	///////////


	//((cCustoFa*cPercD)/100)
	//cVdescR  := ((cVdesc*cPercD)/100)

	cVdescR :=DesU

	//cCuRepo := cCustoFa + cVICMST + cIPI + cRdesc + cRfrete +cRsegCa +cRoutCus

	cRepos  := cCuRepo
	cVdescA := cVdescA - DesU

	return



	_oDlgfa:End()




STATIC Function ATUFILIAL(profil)
	// Variaveis Locais da Funcao

	// Variaveis Private da Funcao
	Private _oDlgAF				// Dialog Principal
	// Variaveis que definem a Acao do Formulario
	Private VISUAL := .F.
	Private INCLUI := .F.
	Private ALTERA := .F.
	Private DELETA := .F.
	// Privates das ListBoxes
	Private aListBox5 := {}
	Private oListBox5
	Private profil

	DEFINE MSDIALOG _oDlgAF TITLE "Atualização de Filial" FROM C(214),C(212) TO C(400),C(680) PIXEL

	// Cria Componentes Padroes do Sistema
	@ C(080),C(013) Button "Confirma" Size C(037),C(012) PIXEL OF _oDlgAF ACTION FModPf(profil)
	@ C(080),C(067) Button "Sair" Size C(037),C(012) PIXEL OF _oDlgAF ACTION _oDlgAF:end()

	// Chamadas das ListBox do Sistema
	fListBox5(profil)

	ACTIVATE MSDIALOG _oDlgAF CENTERED

Return(.T.)

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³fListBox1() ³ Autor ³ Ricardo Mansano       ³ Data ³18/07/2013³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Montagem da ListBox                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fListBox5(profil2)

	// Para editar os Campos da ListBox inclua a linha abaixo
	// na opcao de DuploClick da mesma, ou onde for mais conveniente
	// lembre-se de mudar a picture respeitando a coluna a ser editada
	// PS: Para habilitar o DuploClick selecione a opção MarkBrowse da
	//     ListBox para SIM.
	// lEditCell( aListBox, oListBox, "@!", oListBox:ColPos )

	@ C(015),C(014) ListBox oListBox5 Fields ;
	HEADER "Filial","Varejo"," Atacado";
	Size C(200),C(050) Of _oDlgAF Pixel;
	ColSizes 100,50,50;
	On DBLCLICK (;
	Iif(oListBox5:ColPos==2,lEditCell( aListBox5, oListBox5, "@E 999,999.99", oListBox5:ColPos),nil),;
	Iif(oListBox5:ColPos==3,lEditCell( aListBox5, oListBox5, "@E 999,999.99", oListBox5:ColPos),nil),;
	oListBox5:Refresh(aListBox5))

	oListBox5:SetArray(aListBox5)


	// Carrege aqui sua array da Listbox


	dbSelectArea("SM0")
	dbgotop()

	do while !SM0->(Eof())
		cCFI:= rtrim(SM0->M0_CODFIL)
		cCIDA:=SM0->M0_CIDENT
		dbSelectArea("SB0")
		dbSetOrder(1)
		dbseek(cCFI+profil2)
		Aadd(aListBox5,{cCFI+" - "+cCIDA,SB0->B0_PRV1,SB0->B0_PRV2})

		dbSelectArea("SM0")
		SM0->(DBSKIP())
	enddo


	oListBox5:bLine := {||{;
	aListBox5[oListBox5:nAT,01],;
	aListBox5[oListBox5:nAT,02],;
	aListBox5[oListBox5:nAT,03]}}



Return Nil

Static Function FModPf(cpfil)

	nCnot:= 0

	for _nI := 1 to len(aListBox5)

		mcFipro:= LEFT(aListBox5[_nI,1],4)

		dbSelectArea("SB0")
		dbsetorder(1)
		dbseek(mcFipro+cpfil)
		if Found()
			RecLock("SB0",.F.)
			SB0->B0_PRV1  := round(aListBox5[_nI,2],2)
			SB0->B0_PRV2  := round(aListBox5[_nI,3],2)
			SB0->B0_ALTERA := DATE()
			nCnot++
		endif
		SB0->(MsUnLock())

	next

	_oDlgAF:end()

	if nCnot > 0
		MSGINFO("Preços Atualizado Com Sucesso...")
	else
		MSGINFO("Erro Na Atualizado de Preço...")
	endif

return



Static Function FaObs(obs)

	Local oMemoPe
	Local cMemoPe := obs
	Local _oDlgoBS

	DEFINE FONT oFONT1 NAME "ARIAL"  SIZE   0, -15
	DEFINE MSDIALOG _oDlgoBS TITLE "Pedido de Compra" FROM C(000),C(000) TO C(200),C(500) PIXEL

	@ C(005) ,C(005)  SAY   "OBSERVAÇÃO DO PEDIDO"   OF _oDlgoBS Pixel size C(0200),C(012) FONT oFONT1

	oMemoPe:= tMultiget():New(20,10,{|u|if(Pcount()>0,cMemoPe:=u,cMemoPe)};
	,_oDlgoBS,190,70,,,,,,.T.,,,,,,.T.)


	@ C(080),C(005) Button "Sair" Size C(037),C(012) PIXEL OF _oDlgoBS ACTION _oDlgoBS:END()

	ACTIVATE MSDIALOG _oDlgoBS CENTERED

return

// Rotina Automatica
STATIC FUNCTION finicia(cVb,lSde,cVde,cVouDe)
	Local Titulo :="Aguarde a precificação Automatica......"

	if MsgYesNo("Confirma Precificação ?")
		Processa({||Fpauto(cVb,lSde,cVde,cVouDe)},Titulo)
	else
		return
	endif

RETURN

STATIC FUNCTION Fpauto(cVb,lSde,cVde,cVouDe)

	IF cVb > 0
		ALERT("Precificação Não Pode Ser Automatica Existe Bonificação,Verifique !")
		RETURN
	ENDIF

	IF cVde > 0
		IF lSde = .f.
			ALERT("Precificação Não Pode Ser Automatica Existe Desconto,Verifique !")
			RETURN
		ENDIF
	ENDIF

	IF cVouDe > 0
		ALERT("Precificação Não Pode Ser Automatica Existe outras Despesas ,Verifique !")
		RETURN
	ENDIF






	for _nI := 1 to len(aListBox2)
		if aListBox2[_nI,1] <>'OK'
			cFamil:= POSICIONE("SB1",1,xFilial("SB1")+aListBox2[_nI,2],"B1_CFAM")
			IF EMPTY(cFamil)
				FPREAUT(aListBox2[_nI,2],aListBox2[_nI,3])
			ENDIF
		endif

	NEXT

RETURN

// Calculo para Rotina Automatica

STATIC FUNCTION FPREAUT(cProd,cNomeP)
	Private cBloque := ''
	//Private cVquant
	//Private cRepos
	//Private cVLREAL
	//Private _oDlgM
	// Variaveis para alteração caso estejam errados os dados

	/*
	Local cEdit2	 := Space(30)
	Local cEdit3	 := Space(30)
	Local cEdit5	 := Space(30)
	Local cEdit6	 := Space(30)

	Private cCuAntF
	Private cVquant
	Private cRepos
	Private cVLREAL
	Private _oDlgM



	dbSelectArea("SB1")
	dbSetOrder(1)
	Dbseek(xFilial("SB1")+cProd)
	cNomeP:= B1_DESC
	cGruAl := B1_GRUPO
	cFamAl := B1_CFAM
	cMarAl := B1_MARCA
	cFabAl := B1_FABR


	IF EMPTY(cFamAl)
	cEdit2	 := Space(30)
	ELSE
	cEdit2   := POSICIONE("SZ1",1,xFilial("SZ1")+cFamAl,"Z1_DESC")
	ENDIF

	IF EMPTY(cGruAl)
	cEdit3	 := Space(30)
	ELSE
	cEdit3   := POSICIONE("SBM",1,xFilial("SBM")+cGruAl,"BM_DESC")
	ENDIF

	IF EMPTY(cMarAl)
	cEdit5	 := Space(30)
	ELSE
	cEdit5    := POSICIONE("SZ7",1,xFilial("SZ7")+cMarAl,"Z7_DESC")
	ENDIF

	IF EMPTY(cFabAl)
	cEdit6	 := Space(30)
	ELSE
	cEdit6    := POSICIONE("SZ6",1,xFilial("SZ6")+cFabAl,"Z6_DESC")
	ENDIF

	cVisual:= .F.
	lfm:=  .f.
	DEFINE FONT oFONT4 NAME "ARIAL"  SIZE   0, -15
	DEFINE MSDIALOG _oDlgM TITLE "Informações Analisar" FROM C(267),C(183) TO C(550),C(980) PIXEL

	// Cria Componentes Padroes do Sistema
	@ C(007),C(003) SAY cProd+" "+cNomeP  Size C(0150),C(009) COLOR CLR_BLACK PIXEL OF _oDlgM FONT oFONT4

	@ C(017),C(003) Say "Familia" Size C(018),C(008) COLOR CLR_BLACK PIXEL OF _oDlgM
	@ C(017),C(172) Say "Grupo" Size C(018),C(008) COLOR CLR_BLACK PIXEL OF _oDlgM

	@ C(047),C(003) Say "Marca" Size C(018),C(008) COLOR CLR_BLACK PIXEL OF _oDlgM
	@ C(047),C(172) Say "Fabricante" Size C(030),C(008) COLOR CLR_BLACK PIXEL OF _oDlgM

	@ C(027),C(003) MsGet cFamAl F3 "SZ1"   Size C(020),C(009) COLOR CLR_BLACK PIXEL OF _oDlgM
	@ C(027),C(30) MsGet  cEdit2 Size C(0100),C(009) COLOR CLR_BLACK PIXEL OF _oDlgM WHEN cVisual = .T.
	@ C(027),C(172) MsGet cGruAl F3 "SBM" Size C(020),C(009) COLOR CLR_BLACK PIXEL OF _oDlgM VALID !EMPTY(cGruAl)
	@ C(027),C(197) MsGet cEdit3 Size C(0100),C(009) COLOR CLR_BLACK PIXEL OF _oDlgM WHEN cVisual = .T.

	@ C(057),C(003) MsGet cMarAl F3 "SZ7"   SIZE C(020),C(009) COLOR CLR_BLACK PIXEL OF _oDlgM VALID !EMPTY(cGruAl)
	@ C(057),C(30) MsGet  cEdit5 Size C(0100),C(009) COLOR CLR_BLACK PIXEL OF _oDlgM WHEN cVisual = .T.

	@ C(057),C(172) MsGet cFabAl F3 "SZ6" Size C(020),C(009) COLOR CLR_BLACK PIXEL OF _oDlgM VALID !EMPTY(cGruAl)
	@ C(057),C(201) MsGet cEdit6 Size C(0100),C(009) COLOR CLR_BLACK PIXEL OF _oDlgM WHEN cVisual = .T.

	@ C(100),C(024) Button "Sair" Size C(037),C(012) PIXEL OF _oDlgM action(_oDlgM:END())
	@ C(100),C(075) Button "Confirma" Size C(037),C(012) PIXEL OF _oDlgM action(lfm:= .t.,_oDlgM:END())


	ACTIVATE MSDIALOG _oDlgM CENTERED

	IF lfm = .t.
	dbSelectArea("SB1")
	dbSetOrder(1)
	RecLock("SB1",.F.)
	SB1->B1_GRUPO  :=  cGruAl
	SB1->B1_CFAM   :=  cFamAl
	SB1->B1_MARCA  :=  cMarAl
	SB1->B1_FABR   :=  cFabAl
	SB1->(MsUnLock())
	ENDIF

	///

	dbSelectArea("SZ2")
	dbSetOrder(1)
	Dbseek(xFilial("SB0")+cNota+cSerie+cFornece+cLoja+cProd)

	IF FOUND()
	cFlag := SZ2->Z2_FLAG

	// Atualizando as informações caso o item ja esteja precificado
	IF cFlag  = "OK"
	// Atualizando o Desconto
	IF SZ2->Z2_VLRDR <> 0
	if !lsimde
	cVdescA := cVdescA + SZ2->Z2_VLRDR
	// Voltando o Produto para o status de sem precificação
	RecLock("SZ2",.F.)
	SZ2->Z2_FLAG  := "  "
	SZ2->(MsUnLock())
	endif
	ENDIF

	// Atualizando a Bonificação
	IF SZ2->Z2_VLRBON <> 0
	cVlrBoA := cVlrBoA + SZ2->Z2_VLRBON

	dbSelectArea("SZB")
	RecLock('SZB',.T.)
	SZB->ZB_FILIAL  := xFilial("SD1")
	SZB->ZB_FORNECE := cFornece
	SZB->ZB_LOJA    := cLoja
	SZB->ZB_NOTA    := cNota
	SZB->ZB_SERIE   := cSerie
	SZB->ZB_VALOR   := SZ2->Z2_VLRBON
	SZB->ZB_DATA    := Date()
	SZB->ZB_TIPO    := "C"
	SZB->ZB_EMISSAO := cEmissao
	SZB->ZB_CGC     := cCGC8
	SZB->ZB_OBSERV  := "CANCEL.PRECIF. DE PRODUTO"
	SZB->(MsUnlock())

	// Baixa na Bonificacao
	dbSelectArea("SZC")
	dbSetOrder(1)
	dBseek(xFilial("SZC")+cCgc8)

	IF FOUND()
	RecLock('SZC',.F.)
	SZC->ZC_SALDO += SZ2->Z2_VLRBON
	SZC->ZC_ULTDATA := Date()
	SZC->(MsUnlock())
	ENDIF
	// Voltando o Produto para o status de sem precificação
	dbSelectArea("SZ2")
	RecLock("SZ2",.F.)
	SZ2->Z2_FLAG  := "  "
	SZ2->Z2_VLRBON := 0
	SZ2->(MsUnLock())

	ENDIF

	ENDIF
	ENDIF

	*/


	dbSelectArea("SD1")
	dbSetOrder(1)
	Dbseek(xFilial("SD1")+cNota+cSerie+cFornece+cLoja+cProd)
	if found()

		cVTotal:= SD1->D1_TOTAL
		cUTotal:= SD1->D1_VUNIT
		cVquant:= SD1->D1_QUANT
		cPercN:= (cVTotal/cVlrBrut)*100

		if lSimDe =.T.
			cPercD:= (cVdesc/cVlrBrut)*100
		ENDIF
		cTES:= SD1->D1_TES


		cVICMST :=SD1->D1_ICMSRET/cVquant
		cPicmsC:= SD1->D1_PICM

		cPPisC:= SD1->D1_ALQPIS  // PIS DE CREDITO
		cPCONFC:= SD1->D1_ALQCOF // CONFIS DE CREDITO


		cTicmST:=.F.


		cICMST1P := POSICIONE("SF4",1,xFilial("SF4")+cTES,"F4_ICM")
		cICMST2P := POSICIONE("SF4",1,xFilial("SF4")+cTES,"F4_CREDICM")
		cICMST3P := POSICIONE("SF4",1,xFilial("SF4")+cTES,"F4_SITTRIB")
		cICMST4P := POSICIONE("SF4",1,xFilial("SF4")+cTES,"F4_ANTICMS")

		IF  cICMST3P ="10"
			cTicmST:= .T.
		ELSE
			IF cICMST3P ="60"
				cTicmST:= .T.
			ENDIF
		ENDIF




		cAicmD:=GETMV("MV_ICMPAD2")

		IF  cICMST3P ="40"
			cAicmD:=0
		ELSE

		ENDIF

		cVAtac:=POSICIONE("SB0",1,xFilial("SB0")+cProd,"B0_PRV2")
		cVAvar:=POSICIONE("SB0",1,xFilial("SB0")+cProd,"B0_PRV1")
		cVAPR3:=POSICIONE("SB0",1,xFilial("SB0")+cProd,"B0_PRV6")
		cPerV :=POSICIONE("SB0",1,xFilial("SB0")+cProd,"B0_PVENDA")
		vMarPr3 :=POSICIONE("SB0",1,xFilial("SB0")+cProd,"B0_MKPPR3")
		cMarEst2V:=POSICIONE("SB0",1,xFilial("SB0")+cProd,"B0_PVENDA")

		nQtdPr:= SB0->B0_QTDPR3
		nQtdAt := SB0->B0_QTD2

		cCustoFa2:= SD1->D1_VUNIT
		cCustCont:= SD1->D1_VUNIT // custo contabil utilizado para consumir o cmv  na contabilidade

		if lSimDe =.T.
			IF cVdesc > 0
				cCustoFa2 := cCustoFa2-((cCustoFa2*cPercD)/100)
				cVdescR  := ((cVdesc*cPercD)/100)

			ENDIF
		ENDIF


		cIPI:=(cUTotal*SD1->D1_IPI)/100

		cRdesc := ((cDescar*cPercN)/100)/cVquant
		cRfrete:= (((cFrete+cFreteEX)*cPercN)/100)/cVquant
		cRsegCa:= ((cSegCar*cPercN)/100)/cVquant
		cRoutCus:=((cOuCust*cPercN)/100)/cVquant


		cRBonif:=0

		cICMtri:= (cUTotal*cAicmD)/100

		//cPedido:= SD1->D1_PEDIDO
		cPedido:= SD1->D1_PEDXML



		cPreSug:= 0

		cGrTrib := POSICIONE("SB1",1,xFilial("SB1")+cProd,"B1_GRTRIB")
		cPPisD:= 0
		cPCONFD:= 0


		dbSelectArea("SF7")
		dbSetOrder(3)
		Dbseek(xFilial("SF7")+cGrTrib)
		IF FOUND()

			DO WHILE SF7->F7_FILIAL = xFilial("SF7") .AND. SF7->F7_GRTRIB = cGrTrib .AND. SF7->F7_EST = "**" .AND. SF7->F7_GRPCLI ="CF"


				IF F7_GRPCLI ="CF"
					cPPisD:= SF7->F7_ALIQPIS
					cPCONFD:= SF7->F7_ALIQCOF
					IF cTicmST = .T.
						cICMST := SF7->F7_ALIQEXT
						cPicmsC:= 0
						cAicmD := 0
					ELSE
						cICMST := 0
						//   cPicmsC:= 0
						//   cAicmD := 0
						If SF7->F7_BASEICM > 0
							cAicmD:= ROUND(cAicmD * (SF7->F7_BASEICM / 100),0)
						EndIf

					ENDIF
					EXIT
				ELSE
					cPPisD := 0
					cPCONFD:= 0
					cICMST := 0
					cPicmsC:= 0
					cAicmD := 0

				ENDIF

				dbskip()
			ENDDO
		ENDIF


		//ALERT(cICMST)
		//ALERT(cICMVST)
		//ALERT(SD1->D1_VUNIT)


		if cICMST<>0
			cICMVST:=(SD1->D1_VUNIT*cICMST)/100
		else
			cICMVST:=0
		endif


		//  Mudando a Variavel do Custo de Reposição para custo de reposição Médio

		cCuRepo2:= cCustoFa2 + cVICMST + cIPI + cRdesc + cRfrete +cRsegCa +cRoutCus
		cRepos2 := cCuRepo2
		cCustCont:= (cCustCont + cVICMST + cIPI + cRdesc + cRfrete +cRsegCa +cRoutCus)-(cCustCont*(cPicmsC/100))-(cCustCont*(cPPisD/100))-(cCustCont*(cPCONFD/100))

		cEstoq1  := POSICIONE("SB2",2,xFilial("SB2")+"01"+cProd,"B2_QATU")
		cCuRMed := POSICIONE("SB2",2,xFilial("SB2")+"01"+cProd,"B2_CREPM")
		cCuFMed := POSICIONE("SB2",2,xFilial("SB2")+"01"+cProd,"B2_CFABM")
		cCusCoGr:= POSICIONE("SB2",2,xFilial("SB2")+"01"+cProd,"B2_CCONT")

		cVqmedia := cEstoq1 - cVquant

		IF cVqmedia < 0
			cVqmedia := 0
		ENDIF

		cCalRM1 := cCuRMed * cVqmedia
		cCalRM2 := cCuRepo2 * cVquant

		cCalFM1 := cCuFMed * cVqmedia
		cCalFM2 := cCustoFa2 * cVquant

		cCalCM1 := cCusCoGr * cVqmedia
		cCalCM2 := cCustCont * cVquant


		cCuRepo :=  (cCalRM1 +cCalRM2) / (cVqmedia+cVquant)
		cRepos  := cCuRepo

		cCustoFa :=  (cCalFM1+cCalFM2) / (cVqmedia+cVquant)

		cCustCont :=  (cCalCM1+cCalCM2) / (cVqmedia+cVquant)

		/*
		if lSimDe =.T.
		IF cVdesc > 0
		cCustoFa2 := cCustoFa2-((cCustoFa2*cPercD)/100)
		cVdescR  := ((cVdesc*cPercD)/100)
		// cVdescA  := cVdescA - cVdescR
		ENDIF
		ENDIF
		*/

		//

	ELSE
		ALERT("Este Produto Não Pertence a Nota,Verifique TABELA SD1 !")

	endif





	dbSelectArea("SC7")
	dbSetOrder(2)
	Dbseek(xFilial("SC7")+cProd+cFornece+cLoja+cPedido)
	if found()
		cPreSug := SC7->C7_PVENAT
	endif
	cMarEst:= 0        //Margem Estipulada
	cMarMin:= 0        //Margem Minima
	cMarMax:= 0        //Margem Maxima
	// Aguardando Custos Anterior
	cCusAnt := POSICIONE("SB2",1,xFilial("SB2")+cProd+"01","B2_CM1")  // Custo anterior Final
	cCusAnR := POSICIONE("SB2",1,xFilial("SB2")+cProd+"01","B2_CREPOS") // Custo de Reposicao
	cCusAnF := POSICIONE("SB2",1,xFilial("SB2")+cProd+"01","B2_CFAB") // Custo de Fabrica
	cCuAntF := POSICIONE("SB2",2,xFilial("SB2")+"01"+cProd,"B2_CFAB")

	/*
	//
	cMarEst:=POSICIONE("SB0",1,xFilial("SB0")+cProd,"B0_MARESP")
	IF cMarEst = 0
	cGrupo := POSICIONE("SB1",1,xFilial("SB1")+cProd,"B1_GRUPO")
	cMarEst:= POSICIONE("SZE",1,xFilial("SZE")+cGrupo,"ZE_MARESP")
	cMarMin:= POSICIONE("SZE",1,xFilial("SZE")+cGrupo,"ZE_MARMIN")
	cMarMax:= POSICIONE("SZE",1,xFilial("SZE")+cGrupo,"ZE_MARMAX")
	cPerV :=  POSICIONE("SZE",1,xFilial("SZE")+cGrupo,"ZE_PVENDA")

	ELSE
	cMarEst:=POSICIONE("SB0",1,xFilial("SB0")+cProd,"B0_MARESP")
	cMarMin:=POSICIONE("SB0",1,xFilial("SB0")+cProd,"B0_MARMIN")
	cMarMax:=POSICIONE("SB0",1,xFilial("SB0")+cProd,"B0_MARMAX")
	cMarEst2V:=POSICIONE("SB0",1,xFilial("SB0")+cProd,"B0_PVENDA")

	ENDIF
	*/
	cMarEst:=POSICIONE("SB0",1,xFilial("SB0")+cProd,"B0_MARESP")
	cMarMin:=POSICIONE("SB0",1,xFilial("SB0")+cProd,"B0_MARMIN")
	cMarMax:=POSICIONE("SB0",1,xFilial("SB0")+cProd,"B0_MARMAX")
	cMarEst2V:=POSICIONE("SB0",1,xFilial("SB0")+cProd,"B0_PVENDA")


	//cVenLiq := ((cCuFinal*cMarEst)/100)+cCuFinal
	cVenLiq := 0
	cMarEst2:= cMarEst
	cCuFinal := 0

	cICMTRI:=0
	cCOFINS:=0
	cPIS:= 0

	IF cVlrBoA = 0
		cVlrBoA := cVboniR
	ENDIF

	IF lSim
		cVboni:= (cVboniR*cPercN)/100
		cVboniA:= cVboni
	ELSE
		cVboni  := 0
	ENDIF

	lSaiE :=.F.
	cVbonSa := cVlrBoA  // RECUPERANDO O SALDO DA BONIFICAÇÃO PARA RECUPERAR QUANDO NÃO FOR CONFIRMADO
	cVdesU:= 0





	//DEFINE MSDIALOG oDlgP TITLE cProd+" "+cNomeP FROM C(10000),C(175) TO C(10350),C(1190) PIXEL

	/*
	@ C(008),C(007) Say "Fabrica" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP
	@ C(008),C(050) Say "Fabrica Media" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP

	@ C(008),C(093) Say "ICM ST" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(008),C(136) Say "IPI" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(008),C(179) Say "Descarga" Size C(055),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(008),C(222) Say "Frete" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(008),C(265) Say "Seguro Carga" Size C(055),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(008),C(305) Say "Outros Custos" Size C(055),C(008) COLOR CLR_BLACK PIXEL OF oDlgP



	@ C(008),C(345)  Say "Desconto Usado" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oDlgp
	@ C(008),C(385)  Say "Desconto Total" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oDlgp

	@ C(008),C(425)  Say "Valor Bonificado" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oDlgp
	@ C(008),C(468)  Say "Bonificação" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oDlgp
	*/

	/*
	@ C(018),C(007) MsGet cCustoFa2 PICTURE "@E 999,999.99" Size C(035),C(009) COLOR  CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(018),C(050) MsGet cCustoFa PICTURE "@E 999,999.99" Size C(035),C(009) COLOR  CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(018),C(093) MsGet cVICMST PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(018),C(136) MsGet cIPI PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(018),C(179) MsGet cRdesc PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(018),C(222) MsGet cRfrete PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(018),C(265) MsGet cRsegCa PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(018),C(305) MsGet cRoutCus PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0
	*/

	//@ C(018),C(345) MsGet cVdesU PICTURE  "@E 999,999.9999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgp valid CalDe(cVdesU,cProd)    WHEN lSimDe = .f.  .AND. cVdescAC>0
	//@ C(018),C(385) MsGet cVdescA PICTURE "@E 999,999.9999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgp WHEN cFornece = SPACE(6)

	IF lSimDe = .f.  .AND. cVdescAC>0
		CalDe(cVdesU,cProd)
	ENDIF






	//@ C(018),C(425) MsGet cVboni PICTURE "@E 999,999.9999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgp   valid fdboni(cVboni,cprod)  WHEN cVlrBoA <> 0
	//@ C(018),C(468) MsGet cVlrBoA PICTURE "@E 999,999.9999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgp WHEN cFornece = SPACE(6)




	IF cPreSug <> 0
		cVenLiq := cPreSug
		VpreV(cMarEst2,cMarMin,cMarMax,cMarEst,cCustoFa,cCustoFa+cRfrete,cPPisC,cPCONFC,cICMST,cAicmD,cCuRepo,cPPisD,cPCONFD,cVenLiq)
	ENDIF

	/*
	@ C(038),C(351) Say "Tabela Anterior" Size C(065),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(048),C(351) MsGet cVAtac PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(078),C(351) MsGet cVAvar PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0
	// Custo Anterior de Fabrica
	@ C(098),C(351) Say "Custo Anterior" Size C(065),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(0108),C(351) MsGet cCuAntF  PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0
	*/


	// Preço ATACADO

	/*

	@ C(038),C(007) Say "Reposição" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP
	@ C(038),C(050) Say "Reposição Media" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP
	@ C(038),C(093) Say "PIS" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(038),C(136) Say "COFINS" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(038),C(179) Say "ICMS Tributado" Size C(055),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(038),C(222) Say "Custo Final" Size C(025),C(008) COLOR CLR_RED PIXEL OF oDlgP
	@ C(038),C(265) Say "Margem Liquida" Size C(055),C(008) COLOR CLR_BLUE PIXEL OF oDlgP
	@ C(038),C(308) Say "Preço de Atacado" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP
	*/

	/*
	@ C(048),C(007) MsGet cCuRepo2 PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(048),C(050) MsGet cCuRepo PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(048),C(093) MsGet cPIS PICTURE "@E 999,999.9999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(048),C(136) MsGet cCOFINS PICTURE "@E 999,999.9999" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(048),C(179) MsGet cICMtri PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(048),C(222) MsGet cCuFinal PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0
	*/


	If cMarEst2 = 0
		MsgAlert("Produto "+cProd+" com margem de atacado zerada, verifique!")
		Return
	EndIf

	If cPerV = 0
		MsgAlert("Produto "+cProd+" com margem de varejo zerada, verifique!")
		Return
	EndIf

	Vmargem(cMarEst2,cMarMin,cMarMax,cMarEst,cCustoFa,cCustoFa+cRfrete,cPPisC,cPCONFC,cPicmsC,cAicmD,cCuRepo,cPPisD,cPCONFD,vMarPr3,.t.)

	//@ C(048),C(265) MsGet cMarEst2 PICTURE "@E 9,999.99" Size C(035),C(009)  COLOR CLR_BLUE PIXEL OF oDlgP   VALID Vmargem(cMarEst2,cMarMin,cMarMax,cMarEst,cCustoFa,cCustoFa+cRfrete,cPPisC,cPCONFC,cPicmsC,cAicmD,cCuRepo,cPPisD,cPCONFD) WHEN cPreSug = 0
	//@ C(048),C(308) MsGet cVenLiq PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP  WHEN cCustoFa = 0




	// Preço VAREJO

	/*
	@ C(068),C(007) Say "Custo Reposição" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP
	@ C(068),C(050) Say "PIS" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(068),C(093) Say "COFINS" Size C(025),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(068),C(136) Say "ICMS Tributado" Size C(055),C(008) COLOR CLR_BLACK PIXEL OF oDlgP
	@ C(068),C(179) Say "Custo Final" Size C(025),C(008) COLOR CLR_RED PIXEL OF oDlgP
	@ C(068),C(222) Say "Margem Liquida" Size C(055),C(008) COLOR CLR_BLUE PIXEL OF oDlgP
	@ C(068),C(265) Say "Preço de Varejo" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP
	*/

	/*

	@ C(078),C(007) MsGet cCuRepo PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(078),C(050) MsGet cPISV PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(078),C(093) MsGet cCOFINSV PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(078),C(136) MsGet cICMtriV PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(078),C(179) MsGet cCuFinalV PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(078),C(222) MsGet cMarEst2V PICTURE "@E 9,999.99" Size C(035),C(009)  COLOR CLR_BLUE PIXEL OF oDlgP WHEN cCustoFa = 0 //VALID Vmargem(cMarEst2,cMarMin,cMarMax,cMarEst,cCustoFa,cCustoFa+cRfrete,cPPisC,cPCONFC,cICMST,cAicmD,cCuRepo,cPPisD,cPCONFD)
	@ C(078),C(265) MsGet cVenLV PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP  WHEN cCustoFa = 0   &&VALID  VpreV(cMarEst2,cMarMin,cMarMax,cMarEst,cVenLiq)

	*/

	// Aliquotas

	/*
	@ C(098),C(007) Say "Aliquotas" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP

	@ C(108),C(007) Say "PIS Credito" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP
	@ C(108),C(050) Say "COFINS Credito" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP
	@ C(108),C(093) Say "PIS Debito" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP
	@ C(108),C(136) Say "CONFIS Debito" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP
	@ C(108),C(179) Say "ICM Credito" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP
	@ C(108),C(222) Say "ICM Debito" Size C(055),C(008) COLOR CLR_RED PIXEL OF oDlgP

	@ C(118),C(007) MsGet cPPisC  PICTURE "@E 999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(118),C(050) MsGet cPCONFC  PICTURE "@E 999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(118),C(093) MsGet cPPisD  PICTURE "@E 999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(118),C(136) MsGet cPCONFD PICTURE "@E 999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0

	@ C(118),C(179) MsGet cPicmsC PICTURE "@E 999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0
	@ C(118),C(222) MsGet cAicmD PICTURE "@E 999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oDlgP WHEN cCustoFa = 0

	*/

	//@ C(048),C(395) Button "Atualizar Filial" Size C(037),C(012) PIXEL OF oDlgP Action ATUFILIAL(cProd)

	//@ C(150),C(024) Button "Confirma" Size C(037),C(012) PIXEL OF oDlgP Action(oDlgP:END(),lSaiE:=.T.)

	//@ C(150),C(070) Button "Sair" Size C(037),C(012) PIXEL OF oDlgP Action oDlgP:END()



	///ACTIVATE MSDIALOG oDlgP CENTERED

	//lSaiE := .T.

	// IF lSaiE

	// Verificando que o Produto tem Familia
	lFam:= .F.

	/*
	cFamil:= POSICIONE("SB1",1,xFilial("SB1")+cProd,"B1_CFAM")
	IF cFamil<>SPACE(2)
	IF MSGBOX("Deseja Atualizar a Familia do Produto","Observação","YESNO")
	lFam:= .T.
	ELSE
	lFam:= .F.
	ENDIF
	ENDIF
	*/

	//// Gravando os Dados na TABELA da PRECIFICAÇÃO

	lValid:= .T.

	dbSelectArea("SB0")
	dbSetOrder(1)
	Dbseek(xFilial("SB0")+cProd)
	IF FOUND()
		//          ALERT(str(cVenliq,10,2)+"Normal"+STR(SB0->B0_PRV2,10,2))

		IF  cVenliq > SB0->B0_PRV2+(SB0->B0_PRV2*5)/100
			lValid:= .F.
			//         ALERT(STR((SB0->B0_PRV2+(SB0->B0_PRV2*5)/100),10,2)+"     "+STR(cVenliq,10,2))
		ENDIF

		IF cVenliq < SB0->B0_PRV2-(SB0->B0_PRV2*5)/100
			lValid:= .F.
			//       ALERT(STR((SB0->B0_PRV2-(SB0->B0_PRV2*5)/100),10,2)+"     "+STR(cVenliq,10,2))
		ENDIF

	ENDIF


	If !Empty(cBloque)
		lValid:= .F.
	EndIf





	dbSelectArea("SZ2")
	dbSetOrder(1)
	Dbseek(xFilial("SB0")+cNota+cSerie+cFornece+cLoja+cProd)
	IF FOUND()
		do while SZ2->Z2_FILIAL = xFilial("SB0") .AND. SZ2->Z2_DOC = cNota .AND. SZ2->Z2_SERIE = cSerie .AND. SZ2->Z2_FORNECE = cFornece .AND. SZ2->Z2_LOJA = cLoja .AND. SZ2->Z2_PROD = cProd

			IF lValid = .T.
				RecLock("SZ2",.F.)
				SZ2->Z2_FRETET := cFrete
				SZ2->Z2_FRETER := cRFrete
				SZ2->Z2_DESCT := cDescar
				SZ2->Z2_DESCR := cRDesc
				SZ2->Z2_SEGUT := cSegcar
				SZ2->Z2_SEGUR := cRSegca
				SZ2->Z2_OUTCUST := cOuCust
				SZ2->Z2_OUTCUSR := cRoutCus
				SZ2->Z2_IPI := cIPI
				SZ2->Z2_COFINS := cCofins
				SZ2->Z2_VALMERC := cVlrBrut
				SZ2->Z2_CUSTOFA := cCustoFa2
				SZ2->Z2_VICMST  := cVICMST
				SZ2->Z2_PSUGER  := cPreSug
				SZ2->Z2_CUSTORE := cCuRepo2
				SZ2->Z2_ICMTRIV := cICMtriV
				SZ2->Z2_CUFINAL :=  cCuFinal
				SZ2->Z2_CREPM := cCuRepo
				SZ2->Z2_CFABM:= cCustoFa
				SZ2->Z2_MAREST := cMarEst2
				SZ2->Z2_VENLIQ := cVenLiq
				SZ2->Z2_PISV   := cPISV
				SZ2->Z2_COFINSV := cCOFINSV
				SZ2->Z2_ICMTRI := cICMtri
				SZ2->Z2_CUFINAV := cCuFinalV
				SZ2->Z2_MARESTV := cMarEst2V
				SZ2->Z2_VENLV   := cVenLV
				SZ2->Z2_PISC    := cPPisC
				SZ2->Z2_PIS     := cPis
				SZ2->Z2_COFINSC := cPCONFC
				SZ2->Z2_PISD    := cPPisD
				SZ2->Z2_COFINSD := cPCONFD
				SZ2->Z2_ICMCRED := cIcmst
				SZ2->Z2_ICMDEB  := cAicmD
				SZ2->Z2_VAATAC  := cVAtac
				SZ2->Z2_VAVAR   := cVAvar
				SZ2->Z2_FLAG    := "OK"
				SZ2->Z2_FAM     := lFam
				SZ2->Z2_PREFIXO := cPrefixo
				SZ2->Z2_NUMTIT  := cNumTit
				SZ2->Z2_FORDES  := cForDesc
				SZ2->Z2_LOJDES  := cLoDes
				SZ2->Z2_VLRBON  := cVboni
				SZ2->Z2_CUSANT  := cCusAnt
				SZ2->Z2_CANREP  := cCusanr
				SZ2->Z2_CANFAB  := cCusanf
				SZ2->Z2_VLRBR   := cVboniR
				SZ2->Z2_VLRDR   := cVdesU
				SZ2->Z2_PICMSC  := cPicmsC
				SZ2->Z2_CCONT   := cCustCont
				SZ2->Z2_DATAPRE := DATE()
				SZ2->Z2_CUSTRAN := cPrTran
				SZ2->Z2_PR3PIS  := cPISP3
				SZ2->Z2_PR3COF  := cCOFINSP3
				SZ2->Z2_PR3ICMT := cICMtriP3
				SZ2->Z2_PR3CFIN := cCuFinalP3
				SZ2->Z2_PR3MKP  := vMarPr3
				SZ2->Z2_PR3     := cVenPR3
				IF lSim
					SZ2->Z2_BONIF   := "S"
				ENDIF
				lBoni:= .t.
				SZ2->(MsUnLock())
			Else
				RecLock("SZ2",.F.)
				SZ2->Z2_FLAG    := "BL"
				SZ2->(MsUnLock())
			ENDIF

			dbskip()


		ENDDO
	ENDIF

	//////


	aListBox2 := {}
	dbSelectArea("SZ2")
	dbSetOrder(1)
	Dbseek(xFilial("SB0")+cNota+cSerie+cFornece+cLoja)

	DO WHILE SZ2->Z2_DOC = cNota .AND. SZ2->Z2_SERIE = cSerie .AND. SZ2->Z2_FORNECE = cFornece   .AND. SZ2->Z2_LOJA = cLoja .AND. !SZ2->(Eof())
		aadd(aListBox2,{SZ2->Z2_FLAG,SZ2->Z2_PROD,POSICIONE("SB1",1,xFilial("SB1")+SZ2->Z2_PROD,"B1_DESC"),TRANS(SZ2->Z2_QUANT,"@E 99999.999"),TRANS(SZ2->Z2_VUNIT,"@E 99999.99") })
		SZ2->(DbSkip())
	ENDDO

	oListBox2:SetArray(aListBox2)

	oListBox2:bLine := {|| {;
	IIF(aListBox2[oListBox2:nAT,01] = 'OK',oVerde,IIF(aListBox2[oListBox2:nAT,01] = 'BL',oVerme,oBranc)),;
	aListBox2[oListBox2:nAT,02],;
	aListBox2[oListBox2:nAT,03],;
	aListBox2[oListBox2:nAT,04],;
	aListBox2[oListBox2:nAT,05]}}


	oListBox2:Refresh()





RETURN

//// Final da Rotina Automatica


static FUNCTION Legpre()

	BRWLEGENDA("Precificacao","Legenda",;
	{{"BR_VERDE"    ,"Notas com produtos classes C e D"},;
	{"BR_AMARELO"   ,"Notas com produtos classe B"},;
	{"BR_VERMELHO " ,"Notas com produtos classe A"},;
	{"BR_PRETO"   ,"Notas com produtos bloqueados"}})
return(.t.)



// Outras Despesas

static function CalouDe(oUtD,cprod)

	if oUtD > cOutDsAN
		alert("Valor Maior que o Restante da Outras Despesas, Verifique !")
		return .f.
	endif


	cPercD:= oUtD/cVquant



	//cCustoFa2 := cCustoFa2+cPercD



	///////////////
	cCuRepo2:= cCustoFa2 + cVICMST + cIPI + cRdesc + cRfrete +cRsegCa +cRoutCus + cPercD
	cRepos2 := cCuRepo2




	cEstoq1  := POSICIONE("SB2",2,xFilial("SB2")+"01"+cProd,"B2_QATU")
	cCuRMed := POSICIONE("SB2",2,xFilial("SB2")+"01"+cProd,"B2_CREPM")
	cCuFMed := POSICIONE("SB2",2,xFilial("SB2")+"01"+cProd,"B2_CFABM")


 // foi modifica porque estava com os preços zerados
  /*
    IF cCuRMed = 0
       cCuRMed:=cCuRepo2
    ENDIF

    IF cCuFMed = 0
       cCuFMed := cCustoFa2
    ENDIF
*/



	_cQuery:=" SELECT D1_QUANT "
	_cQuery+=" FROM SD1010"
	_cQuery+=" WHERE D1_FILIAL = '"+SD1->D1_FILIAL+"' "
	_cQuery+=" AND   D1_COD = '"+SD1->D1_COD+"' "
	_cQuery+=" AND   SUBSTRING(D1_TES,3,1) = '7' "
	_cQuery+=" AND   D1_DTDIGIT = '"+DTOS(SD1->D1_DTDIGIT)+"' "
	_cQuery+=" AND   D_E_L_E_T_ = ''	"
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),"TMP2",.T.,.T.)

	If Empty(TMP2->D1_QUANT)

	Else
		cEstoq1:= cEstoq1 - TMP2->D1_QUANT
	Endif

	TMP2->(DBCLOSEAREA())

	cVqmedia := cEstoq1 - cVquant



	IF cVqmedia < 0
		cVqmedia := 0
	ENDIF

	cCalRM1 := cCuRMed * cVqmedia
	cCalRM2 := cCuRepo2 * cVquant

	cCalFM1 := cCuFMed * cVqmedia
	cCalFM2 := cCustoFa2 * cVquant



	cCuRepo :=  (cCalRM1 +cCalRM2) / (cVqmedia+cVquant)
	cRepos  := cCuRepo





	cCustoFa :=  (cCalFM1+cCalFM2) / (cVqmedia+cVquant)




	///////////



	//cVdescR :=DesU


	cRepos   := cCuRepo
	cOutDsAN := cOutDsAN - oUtD



return


STATIC FUNCTION FouDesA()

	Local _oDlgoDA
	Local cVadavul:= 0

	DEFINE FONT oFONT1 NAME "ARIAL"  SIZE   0, -15
	DEFINE MSDIALOG _oDlgoDA TITLE "Outras Despesas" FROM C(000),C(000) TO C(150),C(500) PIXEL

	@ C(005) ,C(005)  SAY   "Valor da Despesa"   OF _oDlgoDA Pixel size C(0200),C(012) FONT oFONT1

	@ C(020) ,C(005) Msget cVadavul PICTURE "@E 999,999.99"  OF _oDlgoDA Pixel size C(070),C(012) FONT oFONT1

	@ C(060),C(005) Button "Sair" Size C(037),C(012) PIXEL OF _oDlgoDA ACTION _oDlgoDA:END()

	ACTIVATE MSDIALOG _oDlgoDA CENTERED

	cOutDesp := cVadavul
	cOutDsAN := cVadavul

return


Static Function InTraProd(cPtd)
	/*
	_cQuery:=" SELECT D1_COD"
	_cQuery+=" 	  ,B1_DESC"
	_cQuery+=" 	  ,Z6_DESC AS FABRICANTE"
	_cQuery+=" 	  ,CASE WHEN  COALESCE((SELECT CASE WHEN SUM(ZN_VENVAR + ZN_VENATAC + COALESCE(ZN_VENATAC2,0)) = 0"
	_cQuery+=" 										THEN 1"
	_cQuery+=" 										ELSE SUM(ZN_VENVAR + ZN_VENATAC + COALESCE(ZN_VENATAC2,0))"
	_cQuery+=" 								END"
	_cQuery+=" 						FROM CT1010"
	_cQuery+=" 						LEFT OUTER JOIN SZN010 ON(CT1_FILIAL = ZN_FILIAL"
	_cQuery+=" 												AND ZN_PRODUTO = D1_COD"
	_cQuery+=" 												AND ZN_DATA BETWEEN '"+dtos(date()-60)+"' AND '"+dtos(date())+"')"
	_cQuery+=" 						WHERE CT1010.D_E_L_E_T_ = ''"
	_cQuery+=" 						AND   CT1_CONTA = '1'  ),0) = 0"
	_cQuery+=" 			THEN 0"
	_cQuery+=" 			ELSE  COALESCE(("
	_cQuery+=" 							 ("
	_cQuery+=" 							  SUM(D1_TOTAL)  /"
	_cQuery+=" 												ROUND((SELECT SUM(D1A.D1_TOTAL)"
	_cQuery+=" 														FROM CT1010"
	_cQuery+=" 														LEFT OUTER JOIN SF1010 F1A ON(CT1_FILIAL = F1A.F1_FILIAL"
	_cQuery+=" 																				  AND F1A.F1_DTDIGIT BETWEEN '"+dtos(date()-60)+"' AND '"+dtos(date())+"'"
	_cQuery+=" 																				  AND F1A.F1_STATUS = 'A'"
	_cQuery+=" 																				  AND F1A.D_E_L_E_T_ = '')"
	_cQuery+=" 														LEFT OUTER JOIN SD1010 D1A ON(F1A.F1_FILIAL = D1A.D1_FILIAL"
	_cQuery+=" 																				AND F1A.F1_DOC    = D1A.D1_DOC"
	_cQuery+=" 																				AND F1A.F1_SERIE = D1A.D1_SERIE"
	_cQuery+=" 																				AND F1A.F1_FORNECE = D1A.D1_FORNECE"
	_cQuery+=" 																				AND D1A.D_E_L_E_T_ = '')"
	_cQuery+=" 														LEFT OUTER JOIN SB1010 ON(B1_COD = D1_COD"
	_cQuery+=" 																			   AND SB1010.D_E_L_E_T_ = '')"
	_cQuery+=" 														WHERE CT1010.D_E_L_E_T_ = ''"
	_cQuery+=" 														AND   CT1_CONTA = '1'"
	_cQuery+=" 														AND   B1_MARCA <> '00582'"
	_cQuery+=" 														AND   D1A.D1_CF = '1152'),2) "
	_cQuery+=" 																						)  *"
	_cQuery+=" 																								(SELECT SUM(F1B.F1_VALBRUT)"
	_cQuery+=" 																									FROM SF1010 F1B"
	_cQuery+=" 																									WHERE F1B.F1_FORNECE = '000958'""
	_cQuery+=" 																									AND   F1B.F1_STATUS = 'A'"
	_cQuery+=" 																									AND   F1B.D_E_L_E_T_ = ''"
	_cQuery+=" 																									AND   F1B.F1_DTDIGIT BETWEEN '"+dtos(date()-60)+"' AND '"+dtos(date())+"' )  "
	_cQuery+=" 																																											 ) /"
	_cQuery+=" 																																												 COALESCE((SELECT CASE WHEN SUM(ZN_VENVAR + ZN_VENATAC + COALESCE(ZN_VENATAC2,0)) = 0"
	_cQuery+=" 																																																		THEN 1"
	_cQuery+=" 																																																		ELSE SUM(ZN_VENVAR + ZN_VENATAC + COALESCE(ZN_VENATAC2,0))"
	_cQuery+=" 																																																END"
	_cQuery+=" 																																														FROM CT1010"
	_cQuery+=" 																																														LEFT OUTER JOIN SZN010 ON(CT1_FILIAL = ZN_FILIAL"
	_cQuery+=" 																																																		      AND ZN_PRODUTO = D1_COD"
	_cQuery+=" 																																																			  AND ZN_DATA BETWEEN '"+dtos(date()-60)+"' AND '"+dtos(date())+"')"
	_cQuery+=" 																																														WHERE CT1010.D_E_L_E_T_ = ''"
	_cQuery+=" 																																														AND   CT1_CONTA = '1' ),1),0)"
	_cQuery+=" 	END AS PER_FRETE"
	_cQuery+=" FROM CT1010 "
	_cQuery+=" LEFT OUTER JOIN SF1010 ON(CT1_FILIAL = F1_FILIAL"
	_cQuery+=" 				 AND F1_DTDIGIT BETWEEN '"+dtos(date()-60)+"' AND '"+dtos(date())+"'"
	_cQuery+=" 				 AND   F1_STATUS = 'A'"
	_cQuery+=" 				 AND   SF1010.D_E_L_E_T_ = '')"
	_cQuery+=" LEFT OUTER JOIN SD1010 ON(F1_FILIAL = D1_FILIAL"
	_cQuery+=" 					  AND F1_DOC    = D1_DOC"
	_cQuery+=" 					  AND F1_SERIE = F1_SERIE"
	_cQuery+=" 					  AND F1_FORNECE = F1_FORNECE"
	_cQuery+=" 					  AND SD1010.D_E_L_E_T_ = '')"
	_cQuery+=" LEFT OUTER JOIN SB1010 ON(B1_COD = D1_COD"
	_cQuery+=" 					  AND SB1010.D_E_L_E_T_ = '')"
	_cQuery+=" LEFT OUTER JOIN SZ6010 ON(B1_FABR = Z6_COD"
	_cQuery+=" 					  AND ''      =SZ6010.D_E_L_E_T_ )"
	_cQuery+=" WHERE CT1010.D_E_L_E_T_ = ''"
	_cQuery+=" AND   CT1_CONTA = '1'"
	_cQuery+=" AND   D1_CF = '1152'"
	_cQuery+=" AND   B1_MARCA <> '00582'"
	_cQuery+=" AND   B1_COD = '"+cPtd+"'"
	_cQuery+=" GROUP BY "
	_cQuery+="        D1_COD"
	_cQuery+=" 	     ,B1_DESC"
	_cQuery+=" 	     ,Z6_DESC"
	*/

	_cQuery:=" SELECT D1_COD"
	_cQuery+=" 	  ,B1_DESC"
	_cQuery+=" 	  ,Z6_DESC AS FABRICANTE"
	_cQuery+="	  ,SUM(D1_TOTAL) AS TRA_ITEM"
	_cQuery+="	  ,ROUND((SELECT SUM(D1A.D1_TOTAL)"
	_cQuery+="				FROM CT1010"
	_cQuery+="				LEFT OUTER JOIN SF1010 F1A WITH (NOLOCK) ON(CT1_FILIAL = F1A.F1_FILIAL"
	_cQuery+="											AND F1A.F1_DTDIGIT BETWEEN '"+dtos(date()-60)+"' AND '"+dtos(date())+"'"
	_cQuery+="											AND F1A.F1_STATUS = 'A'"
	_cQuery+="											AND F1A.D_E_L_E_T_ = '')"
	_cQuery+="				LEFT OUTER JOIN SD1010 D1A WITH (NOLOCK) ON(F1A.F1_FILIAL = D1A.D1_FILIAL"
	_cQuery+="										AND F1A.F1_DOC    = D1A.D1_DOC"
	_cQuery+="										AND F1A.F1_SERIE = D1A.D1_SERIE"
	_cQuery+="										AND F1A.F1_FORNECE = D1A.D1_FORNECE"
	_cQuery+="										AND D1A.D_E_L_E_T_ = '')"
	_cQuery+="				LEFT OUTER JOIN SB1010 WITH (NOLOCK) ON(B1_COD = D1_COD"
	_cQuery+="										AND SB1010.D_E_L_E_T_ = '')"
	_cQuery+="				WHERE CT1010.D_E_L_E_T_ = ''"
	_cQuery+="				AND   CT1_CONTA = '1'"
	_cQuery+="				AND   B1_MARCA <> '00582'"
	_cQuery+="				AND   D1A.D1_CF = '1152'),2) AS TRA_TOT"
	_cQuery+="		,(SELECT SUM(F1B.F1_VALBRUT)"
	_cQuery+="			FROM SF1010 F1B WITH (NOLOCK)"
	_cQuery+="			WHERE F1B.F1_FORNECE = '000958'"
	_cQuery+="			AND   F1B.F1_STATUS = 'A'"
	_cQuery+="			AND   F1B.D_E_L_E_T_ = ''"
	_cQuery+="			AND   F1B.F1_DTDIGIT BETWEEN '"+dtos(date()-60)+"' AND '"+dtos(date())+"' )  AS FRETE"
	_cQuery+="	   ,COALESCE((SELECT CASE WHEN SUM(ZN_VENVAR + ZN_VENATAC + COALESCE(ZN_VENATAC2,0)) = 0"
	_cQuery+="						THEN 1"
	_cQuery+="						ELSE SUM(ZN_VENVAR + ZN_VENATAC + COALESCE(ZN_VENATAC2,0))"
	_cQuery+="				END"
	_cQuery+="		FROM CT1010"
	_cQuery+="		LEFT OUTER JOIN SZN010 WITH (NOLOCK) ON(CT1_FILIAL = ZN_FILIAL"
	_cQuery+="								AND ZN_PRODUTO = D1_COD"
	_cQuery+="								AND ZN_DATA BETWEEN '"+dtos(date()-60)+"' AND '"+dtos(date())+"')"
	_cQuery+="		WHERE CT1010.D_E_L_E_T_ = ''"
	_cQuery+="		AND   CT1_CONTA = '1' ),1) AS VENDA"
	_cQuery+=" FROM CT1010 "
	_cQuery+=" LEFT OUTER JOIN SF1010 WITH (NOLOCK) ON(CT1_FILIAL = F1_FILIAL"
	_cQuery+=" 				 AND F1_DTDIGIT BETWEEN '"+dtos(date()-60)+"' AND '"+dtos(date())+"'"
	_cQuery+=" 				 AND   F1_STATUS = 'A'"
	_cQuery+=" 				 AND   SF1010.D_E_L_E_T_ = '')"
	_cQuery+=" LEFT OUTER JOIN SD1010 WITH (NOLOCK) ON(F1_FILIAL = D1_FILIAL"
	_cQuery+=" 					  AND F1_DOC    = D1_DOC"
	_cQuery+=" 					  AND F1_SERIE = F1_SERIE"
	_cQuery+=" 					  AND F1_FORNECE = F1_FORNECE"
	_cQuery+=" 					  AND SD1010.D_E_L_E_T_ = '')"
	_cQuery+=" LEFT OUTER JOIN SB1010 WITH (NOLOCK) ON(B1_COD = D1_COD"
	_cQuery+=" 					  AND SB1010.D_E_L_E_T_ = '')"
	_cQuery+=" LEFT OUTER JOIN SZ6010 WITH (NOLOCK) ON(B1_FABR = Z6_COD"
	_cQuery+=" 					  AND ''      =SZ6010.D_E_L_E_T_ )"
	_cQuery+=" WHERE CT1010.D_E_L_E_T_ = ''"
	_cQuery+=" AND   CT1_CONTA = '1'"
	_cQuery+=" AND   D1_CF = '1152'"
	_cQuery+=" AND   B1_MARCA <> '00582'"
	_cQuery+=" AND   B1_COD = '"+cPtd+"'"
	_cQuery+=" GROUP BY "
	_cQuery+="        D1_COD"
	_cQuery+=" 	     ,B1_DESC"
	_cQuery+=" 	     ,Z6_DESC"
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),"TRZ",.T.,.T.)

	If !Empty(TRZ->TRA_ITEM)
		If TRZ->VENDA > 0
			nIdTra:=  ( ( (TRZ->TRA_ITEM / TRZ->TRA_TOT) * TRZ->FRETE) / TRZ->VENDA)

		Endif

	EndIf

	TRZ->(DBCLOSEAREA())




Return



Static Function InTraFab(cFab)

	_cQuery:=" SELECT CASE WHEN  COALESCE((SELECT CASE WHEN SUM(ZN_VENVAR + ZN_VENATAC + COALESCE(ZN_VENATAC2,0)) = 0"
	_cQuery+=" 										THEN 1"
	_cQuery+=" 										ELSE SUM(ZN_VENVAR + ZN_VENATAC + COALESCE(ZN_VENATAC2,0))"
	_cQuery+=" 								END"
	_cQuery+=" 						FROM CT1010"
	_cQuery+=" 						LEFT OUTER JOIN SZN010 ON(CT1_FILIAL = ZN_FILIAL"
	_cQuery+=" 												AND ZN_PRODUTO IN (SELECT B1_COD"
	_cQuery+=" 																	FROM SB1010"
	_cQuery+=" 																	WHERE B1_FABR = '"+cFab+"'"
	_cQuery+=" 																	AND   SB1010.D_E_L_E_T_ = '')"
	_cQuery+=" 												AND ZN_DATA BETWEEN '"+dtos(date()-60)+"' AND '"+dtos(date())+"')"
	_cQuery+=" 						WHERE CT1010.D_E_L_E_T_ = ''"
	_cQuery+=" 						AND   CT1_CONTA = '1'  ),0) = 0"
	_cQuery+=" 			THEN 0"
	_cQuery+=" 			ELSE  COALESCE(("
	_cQuery+=" 							 ("
	_cQuery+=" 							  SUM(D1_TOTAL)  /"
	_cQuery+=" 												ROUND((SELECT SUM(D1A.D1_TOTAL)"
	_cQuery+=" 														FROM CT1010"
	_cQuery+=" 														LEFT OUTER JOIN SF1010 F1A ON(CT1_FILIAL = F1A.F1_FILIAL"
	_cQuery+=" 																				  AND F1A.F1_DTDIGIT BETWEEN '"+dtos(date()-60)+"' AND '"+dtos(date())+"'"
	_cQuery+=" 																				  AND F1A.F1_STATUS = 'A'"
	_cQuery+=" 																				  AND F1A.D_E_L_E_T_ = '')"
	_cQuery+=" 														LEFT OUTER JOIN SD1010 D1A ON(F1A.F1_FILIAL = D1A.D1_FILIAL"
	_cQuery+=" 																				AND F1A.F1_DOC    = D1A.D1_DOC"
	_cQuery+=" 																				AND F1A.F1_SERIE = D1A.D1_SERIE"
	_cQuery+=" 																				AND F1A.F1_FORNECE = D1A.D1_FORNECE"
	_cQuery+=" 																				AND D1A.D_E_L_E_T_ = '')"
	_cQuery+=" 														LEFT OUTER JOIN SB1010 ON(B1_COD = D1_COD"
	_cQuery+=" 																			   AND SB1010.D_E_L_E_T_ = '')"
	_cQuery+=" 														WHERE CT1010.D_E_L_E_T_ = ''"
	_cQuery+=" 														AND   CT1_CONTA = '1'"
	_cQuery+=" 														AND   B1_MARCA <> '00582'"
	_cQuery+=" 														AND   D1A.D1_CF = '1152'),2) "
	_cQuery+=" 																						)  *"
	_cQuery+=" 																								(SELECT SUM(F1B.F1_VALBRUT)"
	_cQuery+=" 																									FROM SF1010 F1B"
	_cQuery+=" 																									WHERE F1B.F1_FORNECE = '000958'"
	_cQuery+=" 																									AND   F1B.F1_STATUS = 'A'"
	_cQuery+=" 																									AND   F1B.D_E_L_E_T_ = ''"
	_cQuery+=" 																									AND   F1B.F1_DTDIGIT BETWEEN '"+dtos(date()-60)+"' AND '"+dtos(date())+"' )  "
	_cQuery+=" 																																											 ) /"
	_cQuery+=" 																																												 COALESCE((SELECT CASE WHEN SUM(ZN_VENVAR + ZN_VENATAC + COALESCE(ZN_VENATAC2,0)) = 0"
	_cQuery+=" 																																																		THEN 1"
	_cQuery+=" 																																																		ELSE SUM(ZN_VENVAR + ZN_VENATAC + COALESCE(ZN_VENATAC2,0))"
	_cQuery+=" 																																																END"
	_cQuery+=" 																																														FROM CT1010"
	_cQuery+=" 																																														LEFT OUTER JOIN SZN010 ON(CT1_FILIAL = ZN_FILIAL"
	_cQuery+=" 																																																		      AND ZN_PRODUTO IN (SELECT B1_COD"
	_cQuery+=" 																																																									FROM SB1010"
	_cQuery+=" 																																																									WHERE B1_FABR = '"+cFab+"'"
	_cQuery+=" 																																																									AND   SB1010.D_E_L_E_T_ = '')"
	_cQuery+=" 																																																			  AND ZN_DATA BETWEEN '"+dtos(date()-60)+"' AND '"+dtos(date())+"')"
	_cQuery+=" 																																														WHERE CT1010.D_E_L_E_T_ = ''"
	_cQuery+=" 																																														AND   CT1_CONTA = '1' ),1),0)"
	_cQuery+=" 	END AS PER_FRETE"
	_cQuery+=" FROM CT1010 "
	_cQuery+=" LEFT OUTER JOIN SF1010 ON(CT1_FILIAL = F1_FILIAL"
	_cQuery+=" 				 AND F1_DTDIGIT BETWEEN '"+dtos(date()-60)+"' AND '"+dtos(date())+"'"
	_cQuery+=" 				 AND   F1_STATUS = 'A'"
	_cQuery+=" 				 AND   SF1010.D_E_L_E_T_ = '')"
	_cQuery+=" LEFT OUTER JOIN SD1010 ON(F1_FILIAL = D1_FILIAL"
	_cQuery+=" 					  AND F1_DOC    = D1_DOC"
	_cQuery+=" 					  AND F1_SERIE = F1_SERIE"
	_cQuery+=" 					  AND F1_FORNECE = F1_FORNECE"
	_cQuery+=" 					  AND SD1010.D_E_L_E_T_ = '')"
	_cQuery+=" LEFT OUTER JOIN SB1010 ON(B1_COD = D1_COD"
	_cQuery+=" 					  AND SB1010.D_E_L_E_T_ = '')"
	_cQuery+=" LEFT OUTER JOIN SZ6010 ON(B1_FABR = Z6_COD"
	_cQuery+=" 					  AND ''      =SZ6010.D_E_L_E_T_ )"
	_cQuery+=" WHERE CT1010.D_E_L_E_T_ = ''"
	_cQuery+=" AND   CT1_CONTA = '1'"
	_cQuery+=" AND   D1_CF = '1152'"
	_cQuery+=" AND   B1_MARCA <> '00582'"
	_cQuery+=" AND   B1_COD IN(SELECT B1_COD"
	_cQuery+=" 				FROM SB1010"
	_cQuery+=" 				WHERE B1_FABR = '"+cFab+"'"
	_cQuery+=" 				AND   SB1010.D_E_L_E_T_ = '')"
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),"TRZ",.T.,.T.)

	If !Empty(TRZ->PER_FRETE)
		nIdTra:= TRZ->PER_FRETE
	EndIf

	TRZ->(DBCLOSEAREA())



Return


Static Function InTraEst(cPtd)

	_cQuery:=" SELECT D1_COD"
	_cQuery+=" 	  ,B1_DESC"
	_cQuery+=" 	  ,Z6_DESC AS FABRICANTE"
	_cQuery+=" 	  ,CASE WHEN  COALESCE((SELECT CASE WHEN SUM(ZN_VENVAR + ZN_VENATAC + COALESCE(ZN_VENATAC2,0)) = 0"
	_cQuery+=" 										THEN 1"
	_cQuery+=" 										ELSE SUM(ZN_VENVAR + ZN_VENATAC + COALESCE(ZN_VENATAC2,0))"
	_cQuery+=" 								END"
	_cQuery+=" 						FROM CT1010"
	_cQuery+=" 						LEFT OUTER JOIN SZN010 ON(CT1_FILIAL = ZN_FILIAL"
	_cQuery+=" 												AND ZN_PRODUTO = D1_COD"
	_cQuery+=" 												AND ZN_DATA BETWEEN '"+dtos(date()-60)+"' AND '"+dtos(date())+"')"
	_cQuery+=" 						WHERE CT1010.D_E_L_E_T_ = ''"
	_cQuery+=" 						AND   CT1_CONTA = '1'  ),0) = 0"
	_cQuery+=" 			THEN 0"
	_cQuery+=" 			ELSE  COALESCE(("
	_cQuery+=" 							 ("
	_cQuery+=" 							  SUM(D1_TOTAL)  /"
	_cQuery+=" 												ROUND((SELECT SUM(D1A.D1_TOTAL)"
	_cQuery+=" 														FROM CT1010"
	_cQuery+=" 														LEFT OUTER JOIN SF1010 F1A ON(CT1_FILIAL = F1A.F1_FILIAL"
	_cQuery+=" 																				  AND F1A.F1_DTDIGIT BETWEEN '"+dtos(date()-60)+"' AND '"+dtos(date())+"'"
	_cQuery+=" 																				  AND F1A.F1_STATUS = 'A'"
	_cQuery+=" 																				  AND F1A.D_E_L_E_T_ = '')"
	_cQuery+=" 														LEFT OUTER JOIN SD1010 D1A ON(F1A.F1_FILIAL = D1A.D1_FILIAL"
	_cQuery+=" 																				AND F1A.F1_DOC    = D1A.D1_DOC"
	_cQuery+=" 																				AND F1A.F1_SERIE = D1A.D1_SERIE"
	_cQuery+=" 																				AND F1A.F1_FORNECE = D1A.D1_FORNECE"
	_cQuery+=" 																				AND D1A.D_E_L_E_T_ = '')"
	_cQuery+=" 														LEFT OUTER JOIN SB1010 ON(B1_COD = D1_COD"
	_cQuery+=" 																			   AND SB1010.D_E_L_E_T_ = '')"
	_cQuery+=" 														WHERE CT1010.D_E_L_E_T_ = ''"
	_cQuery+=" 														AND   CT1_CONTA = '1'"
	_cQuery+=" 														AND   B1_MARCA <> '00582'"
	_cQuery+=" 														AND   D1A.D1_CF = '1152'),2) "
	_cQuery+=" 																						)  *"
	_cQuery+=" 																								(SELECT SUM(F1B.F1_VALBRUT)"
	_cQuery+=" 																									FROM SF1010 F1B"
	_cQuery+=" 																									WHERE F1B.F1_FORNECE = '000958'"
	_cQuery+=" 																									AND   F1B.F1_STATUS = 'A'"
	_cQuery+=" 																									AND   F1B.D_E_L_E_T_ = ''"
	_cQuery+=" 																									AND   F1B.F1_DTDIGIT BETWEEN '"+dtos(date()-60)+"' AND '"+dtos(date())+"' )  "
	_cQuery+=" 																																											 ) /"
	_cQuery+=" 																																												 COALESCE((SELECT SUM(B2_CREPM*B2_QATU)"
	_cQuery+="																																												 			FROM SB2010"
	_cQuery+="																																												 			WHERE B2_COD = D1_COD"
	_cQuery+="																																												 			AND   SB2010.D_E_L_E_T_ = ''"
	_cQuery+="																																												 			AND   B2_LOCAL = '01'),1),0)"
	_cQuery+=" 	END AS PER_FRETE"
	_cQuery+=" FROM CT1010 "
	_cQuery+=" LEFT OUTER JOIN SF1010 ON(CT1_FILIAL = F1_FILIAL"
	_cQuery+=" 				 AND F1_DTDIGIT BETWEEN '"+dtos(date()-60)+"' AND '"+dtos(date())+"'"
	_cQuery+=" 				 AND   F1_STATUS = 'A'"
	_cQuery+=" 				 AND   SF1010.D_E_L_E_T_ = '')"
	_cQuery+=" LEFT OUTER JOIN SD1010 ON(F1_FILIAL = D1_FILIAL"
	_cQuery+=" 					  AND F1_DOC    = D1_DOC"
	_cQuery+=" 					  AND F1_SERIE = F1_SERIE"
	_cQuery+=" 					  AND F1_FORNECE = F1_FORNECE"
	_cQuery+=" 					  AND SD1010.D_E_L_E_T_ = '')"
	_cQuery+=" LEFT OUTER JOIN SB1010 ON(B1_COD = D1_COD"
	_cQuery+=" 					  AND SB1010.D_E_L_E_T_ = '')"
	_cQuery+=" LEFT OUTER JOIN SZ6010 ON(B1_FABR = Z6_COD"
	_cQuery+=" 					  AND ''      =SZ6010.D_E_L_E_T_ )"
	_cQuery+=" WHERE CT1010.D_E_L_E_T_ = ''"
	_cQuery+=" AND   CT1_CONTA = '1'"
	_cQuery+=" AND   D1_CF = '1152'"
	_cQuery+=" AND   B1_MARCA <> '00582'"
	_cQuery+=" AND   B1_COD = '"+cPtd+"'"
	_cQuery+=" GROUP BY "
	_cQuery+="        D1_COD"
	_cQuery+=" 	     ,B1_DESC"
	_cQuery+=" 	     ,Z6_DESC"
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),"TRZ",.T.,.T.)

	If !Empty(TRZ->PER_FRETE)
		nIdTra:= TRZ->PER_FRETE
	EndIf

	TRZ->(DBCLOSEAREA())

Return



Static Function AnalVen()
	Local cProduto:= SB1->B1_COD+" - "+SB1->B1_DESC


	Local oProduto

	Private oDlgDig
	Private oList1
	Private aList1:= {}
	Private oList2
	Private aList2:= {}
	Private oList3
	Private aList3:= {}
	Private oList4
	Private aList4:= {}
	Private oList5
	Private aList5:= {}
	Private dDt1:= date()- 30
	Private dDt2:= date()- 1
	Private oDt1
	Private oDt2

	Private nPerVar:= 0
	Private nPerAtc := 0
	Private nPerPr3 := 0
	Private cRUNMED := 0
	Private cRUN := 0

	cRUN:= cVenLV - cCuFinalV

	lrec := .t.

	DbSelectArea("ZAY")
	dBSetOrder(1)
	DbSeek(xFilial("ZAY")+SB1->B1_CATEG+SB1->B1_GRUCAT+SB1->B1_DEPTO+SB1->B1_SECAO+SB1->B1_SUBSE)


	While lrec = .t.
		lrec := .f.
		DEFINE MSDIALOG oDlgDig TITLE "Analise Venda" FROM C(306),C(297) TO C(755),C(1280) PIXEL

		@ 000,000 FOLDER oFolder1 OF oDlgDig PROMPT "Item",ZAY_DESC  SIZE 630,285 PIXEL

		@ C(194),C(450) Button "Confirma" Size C(037),C(012) PIXEL OF oFolder1:aDialogs[1] Action(lMantPr := .f. ,oDlgDig:END())
		@ C(194),C(410) Button "Histórico" Size C(037),C(012) PIXEL OF oFolder1:aDialogs[1] Action(mctranFil(SZ2->Z2_FILIAL))

		@ C(007),C(452) Button "Excel" Size C(037),C(012) PIXEL OF oFolder1:aDialogs[2] Action(ExpExc())


		@ C(001),C(003)  Say "Produto" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[1]
		@ C(001),C(145)  Say "Data Inicial" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[1]
		@ C(001),C(192)  Say "Data Final" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[1]

		@ C(007),C(003) MsGet oProduto Var cProduto Size C(140),C(009) COLOR CLR_BLACK Picture "@!" PIXEL OF oFolder1:aDialogs[1] WHEN cCustoFa = 0
		@ C(007),C(145) MsGet oDt1 Var dDt1 Size C(45),C(009) COLOR CLR_BLACK Picture "@!" PIXEL OF oFolder1:aDialogs[1] WHEN lGerent = .t. Valid fList1('2')
		@ C(007),C(192) MsGet oDt2 Var dDt2 Size C(45),C(009) COLOR CLR_BLACK Picture "@!" PIXEL OF oFolder1:aDialogs[1] WHEN lGerent = .t. Valid fList1('2')

		@ C(001),C(240)  Say "Qtd Min Atac" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[1]
		@ C(001),C(287)  Say "Qtd Min Pr3" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[1]
		@ C(001),C(335)  Say "MKP Varejo" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[1]


		@ C(007),C(335) MsGet cMarEst2V Size C(045),C(009) COLOR CLR_BLACK Picture "@E 999,999.99" PIXEL OF oFolder1:aDialogs[1] WHEN lGerent = .t. Valid (fList2('2'),Vmargem(cMarEst2,cMarMin,cMarMax,cMarEst,cCustoFa,cCustoFa+cRfrete,cPPisC,cPCONFC,cPicmsC,cAicmD,cCuRepo,cPPisD,cPCONFD,vMarPr3,.f.))
		@ C(007),C(381) MsGet cMarEst2 Size C(045),C(009) COLOR CLR_BLACK Picture "@E 999,999.99" PIXEL OF oFolder1:aDialogs[1] WHEN lGerent = .t. Valid (fList3('2'),Vmargem(cMarEst2,cMarMin,cMarMax,cMarEst,cCustoFa,cCustoFa+cRfrete,cPPisC,cPCONFC,cPicmsC,cAicmD,cCuRepo,cPPisD,cPCONFD,vMarPr3,.f.))
		@ C(007),C(428) MsGet vMarPr3 Size C(045),C(009) COLOR CLR_BLACK Picture "@E 999,999.99" PIXEL OF oFolder1:aDialogs[1] WHEN lGerent = .t.  Valid(Vmargem(cMarEst2,cMarMin,cMarMax,cMarEst,cCustoFa,cCustoFa+cRfrete,cPPisC,cPCONFC,cPicmsC,cAicmD,cCuRepo,cPPisD,cPCONFD,vMarPr3,.f.))


		@ C(188),C(003)  Say "% Varejo" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[1]
		@ C(188),C(050)  Say "% Atacado" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[1]
		@ C(188),C(097)  Say "% Preço 3" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[1]

		@ C(194),C(003) MsGet nPerVar Size C(045),C(009) COLOR CLR_BLACK Picture "@E 999,999.99" PIXEL OF oFolder1:aDialogs[1] WHEN cCustoFa = 0
		@ C(194),C(050) MsGet nPerAtc Size C(045),C(009) COLOR CLR_BLACK Picture "@E 999,999.99" PIXEL OF oFolder1:aDialogs[1] WHEN cCustoFa = 0
		@ C(194),C(097) MsGet nPerPr3 Size C(045),C(009) COLOR CLR_BLACK Picture "@E 999,999.99" PIXEL OF oFolder1:aDialogs[1] WHEN cCustoFa = 0

		@ C(188),C(240)  Say "Preço Varejo" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[1]
		@ C(188),C(287)  Say "Preço Atacado" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[1]
		@ C(188),C(334)  Say "Preço 3" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[1]

		@ C(194),C(240) MsGet  cVenLV Size C(045),C(009) COLOR CLR_BLACK Picture "@E 999,999.99" PIXEL OF oFolder1:aDialogs[1] WHEN cCustoFa = 0
		@ C(194),C(287) MsGet  cVenLiq Size C(045),C(009) COLOR CLR_BLACK Picture "@E 999,999.99" PIXEL OF oFolder1:aDialogs[1] WHEN cCustoFa = 0
		@ C(194),C(334) MsGet  cVenPR3 Size C(045),C(009) COLOR CLR_BLACK Picture "@E 999,999.99" PIXEL OF oFolder1:aDialogs[1] WHEN cCustoFa = 0




		@ C(001),C(381)  Say "MKP Atacado" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[1]
		@ C(001),C(428)  Say "MKP Preço 3" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[1]
		@ C(007),C(240) MsGet nQtdAt Size C(045),C(009) COLOR CLR_BLACK Picture "@E 999,999" PIXEL OF oFolder1:aDialogs[1] WHEN lGerent = .t. Valid (lrec:= .t.,oDlgDig:end())
		@ C(007),C(287) MsGet nQtdPr Size C(045),C(009) COLOR CLR_BLACK Picture "@E 999,999" PIXEL OF oFolder1:aDialogs[1] WHEN lGerent = .t.


		@ C(001),C(003)  Say "Produto" Size C(045),C(008) COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[2]
		@ C(007),C(003) MsGet oProduto Var cProduto Size C(140),C(009) COLOR CLR_BLACK Picture "@!" PIXEL OF oFolder1:aDialogs[2] WHEN cCustoFa = 0


		@ C(001),C(145) Say "Custo Final" Size C(025),C(008) COLOR CLR_RED PIXEL OF oFolder1:aDialogs[2]
		@ C(001),C(182) Say "Margem Liquida" Size C(055),C(008) COLOR CLR_BLUE PIXEL OF oFolder1:aDialogs[2]
		@ C(001),C(219) Say "Preço de Varejo" Size C(055),C(008) COLOR CLR_RED PIXEL OF oFolder1:aDialogs[2]

		@ C(001),C(256) Say "Sug MKP Varejo" Size C(065),C(008) COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[2]
		@ C(001),C(293) Say "Sug Preço Varejo" Size C(065),C(008) COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[2]
		@ C(001),C(330) Say "Tabela Anterior" Size C(065),C(008) COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[2]

		@ C(001),C(367) Say "R$ UN" Size C(065),C(008) COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[2]
		@ C(001),C(404) Say "R$ UN Médio" Size C(065),C(008) COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[2]


		@ C(007),C(145) MsGet cCuFinalV PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oFolder1:aDialogs[2] WHEN cCustoFa = 0
		@ C(007),C(182) MsGet cMarEst2V PICTURE "@E 9,999.99" Size C(035),C(009)  COLOR CLR_BLUE PIXEL OF oFolder1:aDialogs[2] WHEN lGerent = .t. VALID (Vmargem(cMarEst2,cMarMin,cMarMax,cMarEst,cCustoFa,cCustoFa+cRfrete,cPPisC,cPCONFC,cPicmsC,cAicmD,cCuRepo,cPPisD,cPCONFD,vMarPr3,.f.),cRUN:= cVenLV - cCuFinalV)
		@ C(007),C(219) MsGet cVenLV PICTURE "@E 999,999.99" Size C(035),C(009)  COLOR CLR_RED PIXEL OF oFolder1:aDialogs[2]  WHEN  cCustoFa = 0   &&VALID  VpreV(cMarEst2,cMarMin,cMarMax,cMarEst,cVenLiq)

		@ C(007),C(256) MsGet cSuMkVa PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[2] WHEN cCustoFa = 0
		@ C(007),C(293) MsGet cSuPrVa PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[2] WHEN cCustoFa = 0
		@ C(007),C(330) MsGet cVAvar PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[2] WHEN cCustoFa = 0

		@ C(007),C(367) MsGet cRUN PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[2] WHEN cCustoFa = 0
		@ C(007),C(404) MsGet cRUNMED PICTURE "@E 999,999.99" Size C(035),C(009) COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[2] WHEN cCustoFa = 0



		fList1('1')
		@ C(018),C(240)  Say "Tabela sugestão MKP atacado:" Size C(080),C(008) COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[1]
		fList2('1')
		@ C(056),C(240)  Say "Tabela sugestão MKP preço 3:" Size C(080),C(008) COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[1]
		fList3('1')
		fList4('1')
		@ C(095),C(240)  Say "Cotações de preço:" Size C(080),C(008) COLOR CLR_BLACK PIXEL OF oFolder1:aDialogs[1]
		fList5('1')


		ACTIVATE MSDIALOG oDlgDig CENTERED

	End

	If lVisuali = .f.
		Vmargem(cMarEst2,cMarMin,cMarMax,cMarEst,cCustoFa,cCustoFa+cRfrete,cPPisC,cPCONFC,cPicmsC,cAicmD,cCuRepo,cPPisD,cPCONFD,vMarPr3,.f.)
	EndIf

Return


Static Function ExpExc()

	aDados:= aList4

	cCabe:='Itens da categoria: '+ZAY->ZAY_DESC
	aCabec:={"Codigo","Produto","Class Marca","Preço Var","(%) MKP Var","Contrib. Var","Preço Atc","(%) MKP Atc","Contrib. Atc","Preço Pr3","(%) MKP Pr3","Contrib. Pr3","Share (%)","R$ Venda","Qtd Venda","Lucro"}
	DlgToExcel({ {"ARRAY", cCabe, aCabec, aDados} })

Return

Static Function fList1(MV_PAR01)

	aList1:= {}

	nPerVar := 0
	nPerAtc := 0
	nPerPr3 := 0

	_cQuery2:=" SELECT CASE WHEN SUM(ZN_VENVAR+ZN_VENATAC+COALESCE(ZN_VENATAC2,0)) = 0 THEN 0 ELSE ROUND(SUM(ZN_VENVAR) / SUM(ZN_VENVAR+ZN_VENATAC+COALESCE(ZN_VENATAC2,0))*100 ,2) END AS PerVa"
	_cQuery2+=" 	  ,CASE WHEN SUM(ZN_VENVAR+ZN_VENATAC+COALESCE(ZN_VENATAC2,0)) = 0 THEN 0 ELSE ROUND(SUM(ZN_VENATAC) / SUM(ZN_VENVAR+ZN_VENATAC+COALESCE(ZN_VENATAC2,0))*100 ,2) END AS PerAt"
	_cQuery2+=" 	  ,CASE WHEN SUM(ZN_VENVAR+ZN_VENATAC+COALESCE(ZN_VENATAC2,0)) = 0 THEN 0 ELSE ROUND(SUM(COALESCE(ZN_VENATAC2,0)) / SUM(ZN_VENVAR+ZN_VENATAC+COALESCE(ZN_VENATAC2,0))*100,2) END AS PerPr3"
	_cQuery2+=" FROM SZN010"
	_cQuery2+=" LEFT OUTER JOIN SB1010 ON(B1_COD = ZN_PRODUTO"
	_cQuery2+=" 					  AND SB1010.D_E_L_E_T_ = '')"
	_cQuery2+=" WHERE ZN_FILIAL = '"+SZ2->Z2_FILIAL+"' "
	If Empty(SB1->B1_CFAM)
		_cQuery2+= "AND   B1_COD = '"+SZ2->Z2_PROD+"' "
	Else
		_cQuery2+= "AND   B1_CFAM = '"+SB1->B1_CFAM+"' "
	EndIf
	_cQuery2+=" AND   ZN_DATA BETWEEN '"+Dtos(dDt1)+"' AND '"+Dtos(dDt2)+"' "
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery2),"TRC",.T.,.T.)

	nPerVar := TRC->PerVa
	nPerAtc := TRC->PerAt
	nPerPr3 := TRC->PerPr3

	TRC->(DBCLOSEAREA())

	If !Empty(SB1->B1_CFAM)
		_cQuery2:=" SELECT X.D2_QUANT"
		_cQuery2+=" 	  ,COUNT(X.AUTEN) AS AUTEN"
		_cQuery2+=" 	  ,ROUND(SUM(X.VENDA),2) AS VENDA"
		_cQuery2+=" 	  ,ROUND(SUM(X.LUCRO),2) AS LUCRO"
		_cQuery2+=" FROM(  SELECT B1_CFAM"
		_cQuery2+=" 			,D2_DOC"
		_cQuery2+=" 			,D2_SERIE"
		_cQuery2+=" 			,SUM(D2_QUANT) AS D2_QUANT"
		_cQuery2+=" 			,COUNT(D2_FILIAL) AUTEN "
		_cQuery2+=" 			,ROUND(SUM(D2_TOTAL),2) AS VENDA "
		_cQuery2+=" 			,ROUND(SUM(D2_TOTAL-D2_CFINVEN),2) AS LUCRO "
		_cQuery2+=" 		FROM SD2010  "
		_cQuery2+=" 		LEFT OUTER JOIN SB1010 ON(B1_COD = D2_COD "
		_cQuery2+=" 								AND SB1010.D_E_L_E_T_ = '') "
		_cQuery2+=" 			LEFT OUTER JOIN SF4010 ON(SD2010.D2_FILIAL = F4_FILIAL "
		_cQuery2+=" 								AND SD2010.D2_TES    = F4_CODIGO) "
		_cQuery2+=" 		WHERE D2_FILIAL = '"+SZ2->Z2_FILIAL+"' "
		_cQuery2+=" 		AND   B1_CFAM = '"+SB1->B1_CFAM+"' "
		_cQuery2+=" 		AND   D2_EMISSAO BETWEEN '"+Dtos(dDt1)+"' AND '"+Dtos(dDt2)+"' "
		_cQuery2+=" 		AND   F4_OPEMOV IN ('01','05','09','11','03')  "
		_cQuery2+=" 		AND   SUBSTRING(SD2010.D2_CF,2,3) <> '152' "
		_cQuery2+=" 		AND   SD2010.D_E_L_E_T_ = ''"
		_cQuery2+=" 		GROUP BY B1_CFAM"
		_cQuery2+=" 				,D2_DOC"
		_cQuery2+=" 				,D2_SERIE ) X"
		_cQuery2+=" GROUP BY X.D2_QUANT"
		_cQuery2+=" ORDER BY 1"
	Else
		_cQuery2:= " SELECT D2_QUANT "
		_cQuery2+= "	  ,COUNT(D2_FILIAL) AUTEN "
		_cQuery2+= "	  ,ROUND(SUM(D2_TOTAL),2) AS VENDA "
		_cQuery2+= "	  ,ROUND(SUM(D2_TOTAL-D2_CFINVEN),2) AS LUCRO "
		_cQuery2+= "FROM SD2010  "
		_cQuery2+= "LEFT OUTER JOIN SB1010 ON(B1_COD = D2_COD "
		_cQuery2+= "					  AND SB1010.D_E_L_E_T_ = '') "
		_cQuery2+= " LEFT OUTER JOIN SF4010 ON(SD2010.D2_FILIAL = F4_FILIAL "
		_cQuery2+= "                       AND SD2010.D2_TES    = F4_CODIGO) "
		_cQuery2+= "WHERE D2_FILIAL = '"+SZ2->Z2_FILIAL+"' "
		_cQuery2+= "AND   B1_COD = '"+SZ2->Z2_PROD+"' "
		_cQuery2+= "AND   D2_EMISSAO BETWEEN '"+Dtos(dDt1)+"' AND '"+Dtos(dDt2)+"' "
		_cQuery2+= "AND   F4_OPEMOV IN ('01','05','09','11','03')  "
		_cQuery2+= "AND   SUBSTRING(SD2010.D2_CF,2,3) <> '152' "
		_cQuery2+= "AND   SD2010.D_E_L_E_T_ = '' "
		_cQuery2+= "GROUP BY D2_QUANT "
		_cQuery2+= "ORDER BY 1 "
	EndIf
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery2),"TRC",.T.,.T.)

	nTluc:= 0
	nTVen:= 0
	nTAut:= 0
	nSluc:= 0
	nSVen:= 0
	nSAut:= 0
	dbSelectArea('TRC')
	TRC->(dbGoTop())
	While !TRC->(EOF())
		Aadd(aList1,{TRC->D2_QUANT,TRC->AUTEN,0,0,ROUND(TRC->VENDA,0),0,0,ROUND(TRC->LUCRO,0),0})

		nTluc+= TRC->LUCRO
		nTVen+= TRC->VENDA
		nTAut+= TRC->AUTEN

		TRC->(dbSkip()) // Avanca o ponteiro do registro no arquivo
	EndDo
	TRC->(DBCLOSEAREA())

	For n:=1 To Len(aList1)

		nSAut+= Round(aList1[n,2]/nTAut*100,2)
		nSVen+= Round(aList1[n,5]/nTVen*100,2)
		nSluc+= Round(aList1[n,8]/nTluc*100,2)

		aList1[n,3]:= Round(aList1[n,2]/nTAut*100,2)
		aList1[n,6]:= Round(aList1[n,5]/nTVen*100,2)

		aList1[n,4]:= TRANS(nSAut,"@E 9999.99")
		aList1[n,7]:= TRANS(nSVen,"@E 9999.99")
		aList1[n,9]:= TRANS(nSluc,"@E 9999.99")


	Next


	If 	empty(aList1)
		Aadd(aList1,{"","","","","","","","",""})
	EndIf
	If MV_PAR01 = '1'
		@ C(018),C(002) ListBox oList1 Fields ;
		HEADER "Qtd Venda","Autenticações","(%)/Total","(%) Acumul","(R$) Venda","(%)/Total","(%) Acumul","(R$) Lucro","(%)Total";
		Size C(235),C(170) Of oFolder1:aDialogs[1] Pixel;
		ColSizes 40,40,30,30,35,30,30,30,30
	Endif

	oList1:SetArray(aList1)
	// Cria ExecBlocks das ListBoxes
	oList1:bLine 		:= {|| {;
	aList1[oList1:nAT,01],;
	aList1[oList1:nAT,02],;
	aList1[oList1:nAT,03],;
	aList1[oList1:nAT,04],;
	aList1[oList1:nAT,05],;
	aList1[oList1:nAT,06],;
	aList1[oList1:nAT,07],;
	aList1[oList1:nAT,08],;
	aList1[oList1:nAT,09]}}

	oList1:refresh()

Return

Static Function fList2(MV_PAR1)
	aCab:={}
	aList2:={}
	aadd(aList2,{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})

	For nx1:=1 To 20

		nx:= 2
		cXX:= cMarEst2V
		aCalc:= {}
		For n:=1 To (nx1)
			If n = 1
				aadd(aCalc,{ cMarEst2V, 0 })
			Else
				aadd(aCalc,{ 0, ((((1+cMarEst2V)^1)/nx)-(1/nx)) })
				nTem:= 0
				For nx:=1 to Len(aCalc)
					If Len(aCalc) = nx
						aCalc[nx,1] := (nTem + aCalc[nx,2])/n
						cXX:= aCalc[nx,1]
					Else
						nTem+= aCalc[nx,1]
					EndIf

				Next
			EndIf

		Next

		aList2[1,nx1]:= round(cXX,2)
		aadd(aCab,{cvalToChar(nx1)})

	Next

	If 	empty(aList2)
		Aadd(aList2,{"","","","","","","","","",""})
	EndIf
	If MV_PAR1 = '1'
		@ C(024),C(240) ListBox oList2 Fields ;
		HEADER aCab[1,1],aCab[2,1],aCab[3,1],aCab[4,1],aCab[5,1],aCab[6,1],aCab[7,1],aCab[8,1],aCab[9,1],aCab[10,1],aCab[11,1],aCab[12,1],aCab[13,1],aCab[14,1],aCab[15,1],aCab[16,1],aCab[17,1],aCab[18,1],aCab[19,1],aCab[20,1];
		Size C(250),C(30) Of oFolder1:aDialogs[1] Pixel;
		ColSizes 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15
	Endif
	oList2:SetArray(aList2)
	// Cria ExecBlocks das ListBoxes
	oList2:bLine 		:= {|| {;
	aList2[oList2:nAT,01],;
	aList2[oList2:nAT,02],;
	aList2[oList2:nAT,03],;
	aList2[oList2:nAT,04],;
	aList2[oList2:nAT,05],;
	aList2[oList2:nAT,06],;
	aList2[oList2:nAT,07],;
	aList2[oList2:nAT,08],;
	aList2[oList2:nAT,09],;
	aList2[oList2:nAT,10],;
	aList2[oList2:nAT,11],;
	aList2[oList2:nAT,12],;
	aList2[oList2:nAT,13],;
	aList2[oList2:nAT,14],;
	aList2[oList2:nAT,15],;
	aList2[oList2:nAT,16],;
	aList2[oList2:nAT,17],;
	aList2[oList2:nAT,18],;
	aList2[oList2:nAT,19],;
	aList2[oList2:nAT,20]}}

	oList2:refresh()


Return

Static Function fList5(MV_PAR1)
	aList5:= {}

	_cQuery2:=" SELECT ZP_FILIAL"
	_cQuery2+=" 	  ,B1_COD"
	_cQuery2+=" 	  ,B1_DESC"
	_cQuery2+=" 	  ,ZO_NOME"
	_cQuery2+=" 	  ,ZP_PRVAR"
	_cQuery2+=" 	  ,ZP_PRATAC"
	_cQuery2+=" 	  ,ZP_VAREJO"
	_cQuery2+=" 	  ,ZP_ATACADO"
	_cQuery2+=" 	  ,ZP_DATA"
	_cQuery2+=" 	  ,CASE WHEN ZP_TPRE = '1'"
	_cQuery2+=" 	        THEN 'NORMAL'"
	_cQuery2+=" 	  		ELSE 'PROMOÇÃO'"
	_cQuery2+=" 	  END AS TIPOPR"
	_cQuery2+=" FROM SZP010"
	_cQuery2+=" LEFT OUTER JOIN SB1010 ON(B1_COD = ZP_PRODUTO collate database_default"
	_cQuery2+=" 					  AND SB1010.D_E_L_E_T_ = '')"
	_cQuery2+=" LEFT OUTER JOIN SZO010 ON(ZO_FILIAL = ZP_FILIAL collate database_default"
	_cQuery2+=" 					  AND ZO_CODIGO  = ZP_CODCO collate database_default"
	_cQuery2+=" 					  AND SZO010.D_E_L_E_T_ = '')"
	_cQuery2+=" WHERE ZP_FILIAL = '"+SZ2->Z2_FILIAL+"' "
	_cQuery2+=" AND   ((ZP_PRODUTO = '"+SZ2->Z2_PROD+"' AND  B1_CFAM = '') OR (B1_CFAM = '"+SB1->B1_CFAM+"' AND B1_CFAM <> '') OR (B1_BASE3 = '"+SB1->B1_BASE3+"' AND B1_BASE3 <> ''))"
	_cQuery2+=" AND   SZP010.D_E_L_E_T_ = ''"
	_cQuery2+=" ORDER BY ZP_DATA DESC"
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery2),"TRC",.T.,.T.)

	dbSelectArea('TRC')
	TRC->(dbGoTop())
	While !TRC->(EOF())
		Aadd(aList5,{STOD(TRC->ZP_DATA),TRC->TIPOPR,TRC->B1_COD,AllTrim(TRC->B1_DESC),AllTrim(TRC->ZO_NOME),TRANSFORM(TRC->ZP_PRVAR ,"@E 999,999.99"),TRANSFORM(TRC->ZP_PRATAC ,"@E 999,999.99"),TRANSFORM(TRC->ZP_VAREJO ,"@E 999,999.99"),TRANSFORM(TRC->ZP_ATACADO ,"@E 999,999.99")})

		TRC->(dbSkip()) // Avanca o ponteiro do registro no arquivo
	EndDo
	TRC->(DBCLOSEAREA())



	If 	empty(aList5)
		Aadd(aList5,{"","","","","","","","",""})
	EndIf
	If MV_PAR1 = '1'
		@ C(102),C(240) ListBox oList5 Fields ;
		HEADER "Data","TP Preço","Cod","Produto","Concorrente","Pr Varejo","Pr Atacado","Pr Var Macre","Pr Atac Macre";
		Size C(250),C(085) Of oFolder1:aDialogs[1] Pixel;
		ColSizes 15,15,15,50,15,15,15

	EndIf
	oList5:SetArray(aList5)
	// Cria ExecBlocks das ListBoxes
	oList5:bLine 		:= {|| {;
	aList5[oList5:nAT,01],;
	aList5[oList5:nAT,02],;
	aList5[oList5:nAT,03],;
	aList5[oList5:nAT,04],;
	aList5[oList5:nAT,05],;
	aList5[oList5:nAT,06],;
	aList5[oList5:nAT,07],;
	aList5[oList5:nAT,08],;
	aList5[oList5:nAT,09]}}

	oList3:refresh()

Return


Static Function fList3(MV_PAR1)
	aCab:={}
	aList3:={}
	aadd(aList3,{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})

	For nx1:=1 To 20

		nx:= 2
		cXX:= cMarEst2
		aCalc:= {}
		For n:=1 To (nx1)
			If n = 1
				aadd(aCalc,{ cMarEst2, 0 })
			Else
				aadd(aCalc,{ 0, ((((1+cMarEst2)^1)/nx)-(1/nx)) })
				nTem:= 0
				For nx:=1 to Len(aCalc)
					If Len(aCalc) = nx
						aCalc[nx,1] := (nTem + aCalc[nx,2])/n
						cXX:= aCalc[nx,1]
					Else
						nTem+= aCalc[nx,1]
					EndIf

				Next
			EndIf

		Next

		aList3[1,nx1]:= round(cXX,2)
		aadd(aCab,{cvalToChar(nx1*nQtdAt)})

	Next



	If 	empty(aList3)
		Aadd(aList3,{"","","","","","","","","",""})
	EndIf
	If MV_PAR1 = '1'
		@ C(062),C(240) ListBox oList3 Fields ;
		HEADER aCab[1,1],aCab[2,1],aCab[3,1],aCab[4,1],aCab[5,1],aCab[6,1],aCab[7,1],aCab[8,1],aCab[9,1],aCab[10,1],aCab[11,1],aCab[12,1],aCab[13,1],aCab[14,1],aCab[15,1],aCab[16,1],aCab[17,1],aCab[18,1],aCab[19,1],aCab[20,1];
		Size C(250),C(30) Of oFolder1:aDialogs[1] Pixel;
		ColSizes 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15
	Else
		oList3:aHeaders[1] := aCab[1,1]
		oList3:aHeaders[2] := aCab[2,1]
		oList3:aHeaders[3] := aCab[3,1]
		oList3:aHeaders[4] := aCab[4,1]
		oList3:aHeaders[5] := aCab[5,1]
		oList3:aHeaders[6] := aCab[6,1]
		oList3:aHeaders[7] := aCab[7,1]
		oList3:aHeaders[8] := aCab[8,1]
		oList3:aHeaders[9] := aCab[9,1]
		oList3:aHeaders[10] := aCab[10,1]
		oList3:aHeaders[11] := aCab[11,1]
		oList3:aHeaders[12] := aCab[12,1]

	EndIf
	oList3:SetArray(aList3)
	// Cria ExecBlocks das ListBoxes
	oList3:bLine 		:= {|| {;
	aList3[oList3:nAT,01],;
	aList3[oList3:nAT,02],;
	aList3[oList3:nAT,03],;
	aList3[oList3:nAT,04],;
	aList3[oList3:nAT,05],;
	aList3[oList3:nAT,06],;
	aList3[oList3:nAT,07],;
	aList3[oList3:nAT,08],;
	aList3[oList3:nAT,09],;
	aList3[oList3:nAT,10],;
	aList3[oList3:nAT,11],;
	aList3[oList3:nAT,12],;
	aList3[oList3:nAT,13],;
	aList3[oList3:nAT,14],;
	aList3[oList3:nAT,15],;
	aList3[oList3:nAT,16],;
	aList3[oList3:nAT,17],;
	aList3[oList3:nAT,18],;
	aList3[oList3:nAT,19],;
	aList3[oList3:nAT,20]}}

	oList3:refresh()

Return



Static Function fList4(MV_PAR1)
	aList4:={}

	_cQuery2:= " SELECT B1_COD"
	_cQuery2+= " 	  ,B1_DESC"
	_cQuery2+= " 	  ,CASE Z7_TPMAR"
	_cQuery2+= " 			WHEN '1' THEN 'PRIMEIRO PREÇO'"
	_cQuery2+= " 			WHEN '2' THEN 'INTERMEDIARIO'"
	_cQuery2+= " 			WHEN '3' THEN 'PREMIO'"
	_cQuery2+= " 		END AS CLAS_MARCA"
	_cQuery2+= " 	  ,B0_PRV1 AS VAREJO"
	_cQuery2+= " 	  ,B0_PVENDA AS MKP_VAR"
	_cQuery2+= " 	  ,B0_PRV1-B2_CFINVAR AS R_UN_VAR"
	_cQuery2+= " 	  ,B0_PRV2 AS ATACADO"
	_cQuery2+= " 	  ,B0_MARESP AS MKP_ATAC"
	_cQuery2+= " 	  ,B0_PRV2-B2_CFINATA AS R_UN_ATC"
	_cQuery2+= " 	  ,B0_PRV6 AS PRECO3"
	_cQuery2+= " 	  ,B0_MKPPR3 AS MKP_PR3"
	_cQuery2+= " 	  ,B0_PRV6 - B2_CFINPR3 AS R_UN_PR3"
	_cQuery2+= " 	  ,B0_LUCMCAT AS LUC_MED_CAT"
	_cQuery2+= " 	  ,ROUND(SUM(ZN_VENVAR+ZN_VENATAC+COALESCE(ZN_VENATAC2,0)),2) AS VENDA"
	_cQuery2+= " 	  ,ROUND(SUM(ZN_QTVARE+ZN_QTATAC+COALESCE(ZN_QTATAC2,0)),2) AS QTD"
	_cQuery2+= " 	  ,ROUND(SUM(ZN_VENVAR+ZN_VENATAC+COALESCE(ZN_VENATAC2,0)) - SUM(ZN_CVAR+ZN_CATAC+COALESCE(ZN_CATAC2,0)),2) AS LUCRO"
	_cQuery2+= " FROM SZN010"
	_cQuery2+= " LEFT OUTER JOIN SB1010 ON(B1_COD = ZN_PRODUTO"
	_cQuery2+= " 					  AND SB1010.D_E_L_E_T_ = '')"
	_cQuery2+= " LEFT OUTER JOIN SB0010 ON(B0_FILIAL = ZN_FILIAL"
	_cQuery2+= " 					  AND B0_COD = ZN_PRODUTO"
	_cQuery2+= " 					  AND SB0010.D_E_L_E_T_ = '')"
	_cQuery2+= " LEFT OUTER JOIN SB2010 ON(B2_FILIAL = ZN_FILIAL"
	_cQuery2+= " 					  AND B2_COD    = ZN_PRODUTO"
	_cQuery2+= " 					  AND B2_LOCAL = '01'"
	_cQuery2+= " 					  AND SB2010.D_E_L_E_T_ = '')"
	_cQuery2+= " LEFT OUTER JOIN SZ7010 ON(B1_MARCA = Z7_COD"
	_cQuery2+= " 					  AND SZ7010.D_E_L_E_T_ = '')"
	_cQuery2+= " WHERE ZN_FILIAL = '"+SZ2->Z2_FILIAL+"' "
	_cQuery2+= " AND   ZN_DATA >= '"+DTOS(DATE()-30)+"'"
	_cQuery2+= " AND   B1_FLAGSUG <> '2' "
	_cQuery2+= " AND   B1_MSBLQL <> '1' "
	_cQuery2+= " AND   B1_GRUCAT = '"+SB1->B1_GRUCAT+"' "
	_cQuery2+= " AND   B1_DEPTO  = '"+SB1->B1_DEPTO+"' "
	_cQuery2+= " AND   B1_SECAO  = '"+SB1->B1_SECAO+"' "
	_cQuery2+= " AND   B1_SUBSE  = '"+SB1->B1_SUBSE+"' "
	_cQuery2+= " AND   B1_CATEG  = '"+SB1->B1_CATEG+"' "
	_cQuery2+= " GROUP BY B1_COD"
	_cQuery2+= " 	    ,B1_DESC"
	_cQuery2+= " 	    ,B0_PRV1 "
	_cQuery2+= " 	    ,B0_PVENDA "
	_cQuery2+= " 	    ,B0_PRV2 "
	_cQuery2+= " 	    ,B0_MARESP "
	_cQuery2+= " 	    ,B0_PRV6 "
	_cQuery2+= " 	    ,B0_MKPPR3 "
	_cQuery2+= " 		,B0_PRV1-B2_CFINVAR"
	_cQuery2+= " 		,B0_PRV2-B2_CFINATA"
	_cQuery2+= " 		,B0_PRV6 - B2_CFINPR3"
	_cQuery2+= " 		,CASE Z7_TPMAR"
	_cQuery2+= " 			WHEN '1' THEN 'PRIMEIRO PREÇO'"
	_cQuery2+= " 			WHEN '2' THEN 'INTERMEDIARIO'"
	_cQuery2+= " 			WHEN '3' THEN 'PREMIO'"
	_cQuery2+= " 		END"
	_cQuery2+= " 		,B0_LUCMCAT"
	_cQuery2+= " ORDER BY 14 DESC"
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery2),"TRC",.T.,.T.)

	nTVen:= 0
	cRUNMED:= TRC->LUC_MED_CAT
	dbSelectArea('TRC')
	TRC->(dbGoTop())
	While !TRC->(EOF())

		Aadd(aList4,{TRC->B1_COD,;
		TRC->B1_DESC,;
		TRC->CLAS_MARCA,;
		TRC->VAREJO,;
		TRC->MKP_VAR,;
		TRC->R_UN_VAR,;
		TRC->ATACADO,;
		TRC->MKP_ATAC,;
		TRC->R_UN_ATC,;
		TRC->PRECO3,;
		TRC->MKP_PR3,;
		TRC->R_UN_PR3,;
		0,;
		round(TRC->VENDA,0),;
		TRC->QTD,;
		ROUND(TRC->LUCRO,0)})


		nTVen+= TRC->VENDA


		TRC->(dbSkip()) // Avanca o ponteiro do registro no arquivo
	EndDo
	TRC->(DBCLOSEAREA())

	For n:=1 To Len(aList4)

		aList4[n,13]:= round(aList4[n,14]/ nTVen,2)*100

	Next


	If 	empty(aList4)
		Aadd(aList4,{"","","","","","","","","","","","","","","",""})
	EndIf

	@ C(018),C(002) ListBox oList4 Fields ;
	HEADER "Codigo","Produto","Class Marca","Preço Var","(%) MKP Var","Contrib. Var","Preço Atc","(%) MKP Atc","Contrib. Atc","Preço Pr3","(%) MKP Pr3","Contrib. Pr3","Share (%)","R$ Venda","Qtd Venda","Lucro";
	Size C(490),C(200) Of oFolder1:aDialogs[2] Pixel;
	ColSizes 30,40,30,30,35,30,30,30,30 ,30,30,30,30,30,30,30


	oList4:SetArray(aList4)
	// Cria ExecBlocks das ListBoxes
	oList4:bLine 		:= {|| {;
	aList4[oList4:nAT,01],;
	aList4[oList4:nAT,02],;
	aList4[oList4:nAT,03],;
	aList4[oList4:nAT,04],;
	aList4[oList4:nAT,05],;
	aList4[oList4:nAT,06],;
	aList4[oList4:nAT,07],;
	aList4[oList4:nAT,08],;
	aList4[oList4:nAT,09],;
	aList4[oList4:nAT,10],;
	aList4[oList4:nAT,11],;
	aList4[oList4:nAT,12],;
	aList4[oList4:nAT,13],;
	aList4[oList4:nAT,14],;
	aList4[oList4:nAT,15],;
	aList4[oList4:nAT,16]}}

	oList1:refresh()

Return




Static Function mctranFil(mv_par01)
	// Variaveis Locais da Funcao
	Private _cCod2 := SZ2->Z2_PROD
	Private _cCod :=  SZ2->Z2_PROD
	Private _cDescri2 := SB1->B1_DESC
	Private _cFilial2 := mv_par01
	Private cProdut2:= "Filial: "+_cFilial2+" Produto: "+_cCod2+" - "+_cDescri2

	// Variaveis Private da Funcao
	Private oDlgDig2				// Dialog Principal
	// Variaveis que definem a Acao do Formulario
	Private oProdut2
	Private oFolder1
	Private aFolder1	:= {"Aba1","Aba2","Aba3","Aba4","Aba5","Aba6","Aba7","Aba8"}
	Private cVisu := .f.
	Private oListBoxEm
	Private aListBoxEm := {}
	Private oListBox
	// Privates das ListBoxes
	If empty(mv_par01)
		Return
	EndIf


	_cQuery2:= " SELECT ROUND((ZV_TEMPLOG+ZV_TEMFAT)*ZD_EMIN,0) AS ESTMIN "
	_cQuery2+= " 	  ,ROUND(ZD_EMAX,0) AS ESTMAX "
	_cQuery2+= " FROM SZD010 "
	_cQuery2+= " LEFT OUTER JOIN SZV010 ON(ZV_FILIAL = ZD_FILIAL "
	_cQuery2+= " 			          AND ZV_FORNEC = ZD_FORNECE) "
	_cQuery2+= " WHERE ZD_FILIAL = '"+mv_par01+"'"
	_cQuery2+= " AND   ZD_COD = '"+_cCod+"'"
	_cQuery2+= " AND   ZD_IDUSUAR = '' "
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery2),"TRC",.T.,.T.)

	PR05:=TRC->ESTMAX
	PR04:=TRC->ESTMIN

	TRC->(DBCLOSEAREA())

	DEFINE MSDIALOG oDlgDig2 TITLE "Filial: "+_cFilial2 FROM C(306),C(297) TO C(700),C(1280) PIXEL

	// Cria as Folders do Sistema
	//	oFolder1	:= TFolder():New(C(051),C(006),aFolder1,{},oDlgDig,,,,.T.,.F.,C(480),C(150),)
	@ 050,006 FOLDER oFolder1 OF oDlgDig2 PROMPT "&Venda Diaria (QTD)","V&enda Mensal (QTD)","&Margens (%)","&Categoria grafico (Qtd)","&Tabela Categoria","Ve&nda/Compra (R$)","&Familia (Qtd)","Margem Capital Medio (%)"  SIZE 615,202 PIXEL

	// Cria Componentes Padroes do Sistema
	@ C(001),C(003) MsGet oProdut2 Var cProdut2 Size C(180),C(007) COLOR CLR_BLACK Picture "@!" PIXEL OF oDlgDig2 when cVisu = .t.
	@ C(001),C(460) Button "&Sair" Size C(028),C(010) PIXEL OF oDlgDig2  Action oDlgDig2:end()
	//@ C(013),C(460) Button "Historico" Size C(028),C(010) PIXEL OF oDlgDig2 Action (cfilant1:=SM0->M0_CODFIL,CarFil(_cFilial2),MaComView(_cCod,_cFilial2),CarFil(cfilant1))


	//	@ C(004),C(460) Button "Precificação" Size C(028),C(010) PIXEL OF oDlgDig Action ViEspp(_cCod,PR01)


	// Cria ExecBlocks dos Componentes Padroes do Sistema

	// Chamadas das ListBox do Sistema

	@ C(001),C(430) Button "carregar" Size C(028),C(010) PIXEL OF oFolder1:aDialogs[5] Action (Aba5(_cCod2,_cFilial2,PR05),oFolder1:aDialogs[5]:refresh())
	@ C(001),C(430) Button "carregar" Size C(028),C(010) PIXEL OF oFolder1:aDialogs[4] Action (Aba4(_cCod2,_cFilial2,PR05))
	@ C(001),C(430) Button "carregar" Size C(028),C(010) PIXEL OF oFolder1:aDialogs[3] Action (Aba3(_cCod2,_cFilial2,PR05))
	@ C(001),C(430) Button "carregar" Size C(028),C(010) PIXEL OF oFolder1:aDialogs[6] Action (Aba6(_cCod2,_cFilial2,PR05))
	@ C(001),C(430) Button "carregar" Size C(028),C(010) PIXEL OF oFolder1:aDialogs[8] Action (Aba8(_cCod2,_cFilial2,PR05))
	@ C(001),C(430) Button "carregar" Size C(028),C(010) PIXEL OF oFolder1:aDialogs[2] Action (Aba2(_cCod2,_cFilial2,PR05))

	fListBoxEm()

	Aba1(_cCod2,_cFilial2,PR05,PR04)
	//Aba2(_cCod2,_cFilial2,PR05)
	//Aba3(_cCod2,_cFilial2,PR05)
	//Aba4(_cCod2,_cFilial2,PR05)
	//Aba5(_cCod2,_cFilial2,PR05)
	//Aba6(_cCod2,_cFilial2,PR05)
	Aba7(_cCod2,_cFilial2,PR05)
	//Aba8(_cCod2,_cFilial2,PR05)


	ACTIVATE MSDIALOG oDlgDig2 CENTERED

Return

Static Function Aba1(_cCod,PR01,PR05,PR04)
	Local nHErp := AdvConnection()
	Local Titulo := ""
	DbSelectarea("SA2")
	DbSetOrder(1)
	Dbseek(xfilial("SA2")+SZV->ZV_FORNEC)
	cSUG := SZV->ZV_SUGEST
	cCOB := SZV->ZV_TEMFAT+ SZV->ZV_TEMPLOG  + SB2->B2_ESTSEG
	cESTMIN:=PR04*cCOB
	// u_LinkEst()

	U_fGrafDiar(PR01,_cCod,TITULO,PR05,cESTMIN)
	//	@ C(002),C(009) MsGet oTESTE Var cTESTE PICTURE "@E 999,999.99" Size C(036),C(009) COLOR CLR_BLACK Picture "@!" PIXEL OF oFolder1:aDialogs[1]
	//tcSetConn(nHErp)


Return



Static Function Aba2(_cCod,PR01,PR05)
	Local nHErp := AdvConnection()
	Local Titulo := ""

	DbSelectarea("SA2")
	DbSetOrder(1)
	Dbseek(xfilial("SA2")+SZV->ZV_FORNEC)
	cSUG := SZV->ZV_SUGEST
	cCOB := SZV->ZV_TEMFAT + SZV->ZV_TEMPLOG + SB2->B2_ESTSEG

	// u_LinkEst()

	U_fGrafMes(PR01,_cCod,TITULO,PR05,cCOB,cSUG)
	//	@ C(002),C(009) MsGet oTESTE Var cTESTE PICTURE "@E 999,999.99" Size C(036),C(009) COLOR CLR_BLACK Picture "@!" PIXEL OF oFolder1:aDialogs[1]
	//tcSetConn(nHErp)


Return


Static Function Aba3(_cCod,PR01,PR05)
	Local nHErp := AdvConnection()
	Local Titulo := ""


	//u_LinkEst()

	U_fGraRent(PR01,_cCod,TITULO)
	//	@ C(002),C(009) MsGet oTESTE Var cTESTE PICTURE "@E 999,999.99" Size C(036),C(009) COLOR CLR_BLACK Picture "@!" PIXEL OF oFolder1:aDialogs[1]
	//tcSetConn(nHErp)


Return

Static Function Aba4(_cCod,PR01,PR05)
	Local nHErp := AdvConnection()
	Local Titulo := ""
	Local cCOD := ""
	Local ccod1:=""


	_cQuery2:= "  SELECT  "
	_cQuery2+= "		 SUM(ZN_VENQTD-ZN_DEVQTDV) AS QTD, "
	_cQuery2+= " 	     SUM(ZN_ESTOQUE) AS ZN_ESTOQUE,"
	_cQuery2+= "         SUM(((ZN_VENQTD-ZN_DEVQTDV))*(A2_TEMCOB+B2_ESTSEG)) AS ESTMI ,"
	_cQuery2+= "         SUM(((ZN_VENQTD-ZN_DEVQTDV))*(A2_TEMCOB+ZN_SUGFORN+B2_ESTSEG)) AS ESTMAX,  "
	_cQuery2+= " 	     SUBSTRING(ZN_DATA,7,2) AS DIA   "
	_cQuery2+= "  FROM SZNDIARIO "
	_cQuery2+= "  LEFT OUTER JOIN SB2010 ON(B2_FILIAL = ZN_FILIAL"
	_cQuery2+= "                        AND B2_COD = ZN_PRODUTO"
	_cQuery2+= "                        AND B2_LOCAL  = '01'	"
	_cQuery2+= "						AND SB2010.D_E_L_E_T_ = '' )"
	_cQuery2+= "  WHERE ZN_FILIAL  = '"+PR01+"'"
	_cQuery2+= "  AND   ZN_PRODUTO IN (SELECT B.B1_COD "
	_cQuery2+= " 						FROM SB1010 A  "
	_cQuery2+= " 						LEFT OUTER JOIN SB1010 B ON(A.B1_GRUCAT = B.B1_GRUCAT "
	_cQuery2+= " 						                        AND A.B1_DEPTO  = B.B1_DEPTO "
	_cQuery2+= " 						                        AND A.B1_SECAO  = B.B1_SECAO "
	_cQuery2+= " 						                        AND A.B1_SUBSE  = B.B1_SUBSE "
	_cQuery2+= " 						                        AND A.B1_CATEG  = B.B1_CATEG) "
	_cQuery2+= " 						WHERE A.B1_COD = '"+_cCod+"' "
	_cQuery2+= " 						AND   A.B1_GRUCAT <> '')"
	_cQuery2+= " GROUP BY  ZN_DATA "
	_cQuery2+= " ORDER BY  ZN_DATA "
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery2),"TRC",.T.,.T.)

	If !EMPTY(TRC->DIA)
		U_fGrafDiSi(PR01,cCOD,TITULO)
	Else
		TRC->(DBCLOSEAREA())
	EndIF
	//	@ C(002),C(009) MsGet oTESTE Var cTESTE PICTURE "@E 999,999.99" Size C(036),C(009) COLOR CLR_BLACK Picture "@!" PIXEL OF oFolder1:aDialogs[1]
	//tcSetConn(nHErp)


Return


Static Function Aba5(_cCod,PR01,PR05)
	Fsimilar(_cCod,PR01)

Return


Static Function Aba6(_cCod,PR01,PR05)
	Local nHErp := AdvConnection()
	Local Titulo := ""


	// u_LinkEst()

	U_fGrafvlr(PR01,_cCod,TITULO)
	//	@ C(002),C(009) MsGet oTESTE Var cTESTE PICTURE "@E 999,999.99" Size C(036),C(009) COLOR CLR_BLACK Picture "@!" PIXEL OF oFolder1:aDialogs[1]
	//tcSetConn(nHErp)


Return



Static Function Aba7(_cCod,PR01,PR05)
	Local nHErp := AdvConnection()
	Local Titulo := ""
	Local cCOD := ""
	Local ccod1:=""


	_cQuery2:= "  SELECT  "
	_cQuery2+= "		 SUM(ZN_VENQTD-ZN_DEVQTDV) AS QTD, "
	_cQuery2+= " 	     SUM(ZN_ESTOQUE) AS ZN_ESTOQUE,"
	_cQuery2+= "         SUM(((ZN_VENQTD-ZN_DEVQTDV))*(A2_TEMCOB+B2_ESTSEG)) AS ESTMI ,"
	_cQuery2+= "         SUM(((ZN_VENQTD-ZN_DEVQTDV))*(A2_TEMCOB+ZN_SUGFORN+B2_ESTSEG)) AS ESTMAX,  "
	_cQuery2+= " 	     SUBSTRING(ZN_DATA,7,2) AS DIA   "
	_cQuery2+= "  FROM SZNDIARIO "
	_cQuery2+= "  LEFT OUTER JOIN SB2010 ON(B2_FILIAL = ZN_FILIAL"
	_cQuery2+= "                        AND B2_COD = ZN_PRODUTO"
	_cQuery2+= "                        AND B2_LOCAL  = '01'	"
	_cQuery2+= "						AND SB2010.D_E_L_E_T_ = '' )"
	_cQuery2+= "  WHERE ZN_FILIAL  = '"+PR01+"'"
	_cQuery2+= "  AND   ZN_PRODUTO IN (SELECT B.B1_COD "
	_cQuery2+= " 						FROM SB1010 A  "
	_cQuery2+= " 						LEFT OUTER JOIN SB1010 B ON(A.B1_CFAM = B.B1_CFAM) "
	_cQuery2+= " 						WHERE A.B1_COD = '"+_cCod+"' "
	_cQuery2+= " 						AND   A.B1_CFAM <> '')"
	_cQuery2+= " GROUP BY  ZN_DATA "
	_cQuery2+= " ORDER BY  ZN_DATA "
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery2),"TRC",.T.,.T.)

	If !EMPTY(TRC->DIA)
		U_fGrafDiFA(PR01,cCOD,TITULO)
	Else
		TRC->(DBCLOSEAREA())
	EndIF
	//	@ C(002),C(009) MsGet oTESTE Var cTESTE PICTURE "@E 999,999.99" Size C(036),C(009) COLOR CLR_BLACK Picture "@!" PIXEL OF oFolder1:aDialogs[1]
	//tcSetConn(nHErp)


Return

Static Function Aba8(_cCod,PR01,PR05)
	Local nHErp := AdvConnection()
	Local Titulo := ""


	//u_LinkEst()

	U_fGraReMe(PR01,_cCod,TITULO)
	//	@ C(002),C(009) MsGet oTESTE Var cTESTE PICTURE "@E 999,999.99" Size C(036),C(009) COLOR CLR_BLACK Picture "@!" PIXEL OF oFolder1:aDialogs[1]
	//tcSetConn(nHErp)


Return
Static Function fListBoxEm()

	// Para editar os Campos da ListBox inclua a linha abaixo
	// na opcao de DuploClick da mesma, ou onde for mais conveniente
	// lembre-se de mudar a picture respeitando a coluna a ser editada
	// PS: Para habilitar o DuploClick selecione a opção MarkBrowse da
	//     ListBox para SIM.
	// lEditCell( aListBox, oListBox, "@!", oListBox:ColPos )

	// Carrege aqui sua array da Listbox




	_cQuery2:= " SELECT DISTINCT LK_UM, LK_QUANT "
	_cQuery2+= " FROM SLK010 A "
	_cQuery2+= " WHERE A.LK_CODIGO = '"+_cCod+"' "
	_cQuery2+= " AND   A.D_E_L_E_T_ = '' "
	_cQuery2+= " AND   A.LK_QUANT <> 0 "
	_cQuery2+= " ORDER BY LK_QUANT "
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery2),"TRC",.T.,.T.)

	dbSelectArea('TRC')
	TRC->(dbGoTop())
	While !TRC->(EOF())

		Aadd(aListBoxEm,{" ",TRC->LK_UM,TRC->LK_QUANT})

		TRC->(dbSkip()) // Avanca o ponteiro do registro no arquivo
	EndDo

	TRC->(DBCLOSEAREA())

	If 	empty(aListBoxEm)
		Aadd(aListBoxEm,{"","",""})
	EndIf
	@ C(002),C(380) ListBox oListBoxEm Fields ;
	HEADER "","Emb","Qtd";
	Size C(075),C(040) Of oDlgDig2 Pixel;
	ColSizes 15,30,30

	oListBoxEm:SetArray(aListBoxEm)
	// Cria ExecBlocks das ListBoxes
	oListBoxEm:bLine 		:= {|| {;
	aListBoxEm[oListBoxEm:nAT,01],;
	aListBoxEm[oListBoxEm:nAT,02],;
	aListBoxEm[oListBoxEm:nAT,03]}}

Return Nil

Static  Function Fsimilar(cProduto,_cFiref)


	Local aHeaderCsm	:= {}
	Local aViewAuxCsm	:= {}
	Local aViewCsm3		:= {}
	Local aViewCsm2		:= {}
	Local aViewCsm		:= {}
	Local aPRODUTO      := {}
	Local aMeses		:= {STR0020,STR0021,STR0022,STR0023,STR0024,STR0025,STR0026,STR0027,STR0028,STR0029,STR0030,STR0031} //"Jan"###"Fev"###"Mar"###"Abr"###"Mai"###"Jun"###"Jul"###"Ago"###"Set"###"Out"###"Nov"###"Dez"
	Local nX          := 0
	Local nHErp := AdvConnection()
	vTOTEST := 0
	vTM14:=0
	vTPREN:=0
	vTOTPED:=0
	cQTDPED:=0
	cQTDPNF:=0
	vTM1:=0
	vTM2:=0
	vTM3:=0
	vTM4:=0
	vTM5:=0
	vTM6:=0
	vTM7:=0
	vTM8:=0
	vTM9:=0
	vTM10:=0
	vTM11:=0
	vTM12:=0
	vTM13:=0
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona o cadastro de produtos                                       ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(cProduto)
		dbSelectArea('SB1')
		dbSetOrder(1)
		If MsSeek(xFilial()+cProduto)
			IF !EMPTY(SB1->B1_GRUCAT)

				_cQuery:=" SELECT B1_COD,B1_DESC "
				_cQuery+=" FROM SB1010 "
				_cQuery+=" WHERE B1_GRUCAT = '"+SB1->B1_GRUCAT+"' "
				_cQuery+=" AND   B1_DEPTO  = '"+SB1->B1_DEPTO+"' "
				_cQuery+=" AND   B1_SECAO  = '"+SB1->B1_SECAO+"' "
				_cQuery+=" AND   B1_SUBSE  = '"+SB1->B1_SUBSE+"' "
				_cQuery+=" AND   B1_CATEG  = '"+SB1->B1_CATEG+"' "
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),"TRT",.T.,.T.)

				dbSelectArea('TRT')
				TRT->(dbGoTop())
				While !TRT->(EOF())
					aADD(aPRODUTO,{ALLTRIM(TRT->B1_COD),ALLTRIM(TRT->B1_DESC)})

					TRT->(dbSkip()) // Avanca o ponteiro do registro no arqui

				EndDo

				TRT->(DBCLOSEAREA())

				For n:=1  to len(aPRODUTO)
					//u_LinkEst()

					aViewCsm2	 := {}
					cMeses	:= SPACE(3)
					nAno	:= YEAR(dDataBase)
					nMes	:= MONTH(dDataBase)
					aOrdem	:= {}
					nAno--
					For nx := nMes+1 To 12
						//			aADD(aViewCsm,{aMeses[nx],Str(nAno,4),&("B3_Q"+StrZero(nx,2))})
						aADD(aViewCsm2,{aMeses[nx],Str(nAno,4),CON2(Str(nAno,4)+StrZero(nx,2),aPRODUTO[n][1],_cFiref,"Q"),aPRODUTO[n][1]})
					Next nx
					nAno++
					For nx	:= 1 to nMes
						//			aADD(aViewCsm,{aMeses[nx],Str(nAno,4),&("B3_Q"+StrZero(nx,2))})
						aADD(aViewCsm2,{aMeses[nx],Str(nAno,4),CON2(Str(nAno,4)+StrZero(nx,2),aPRODUTO[n][1],_cFiref,"Q"),aPRODUTO[n][1]})
					Next nx

					if aViewCsm2 <> {}
						aADD(aViewCsm,{aPRODUTO[n][1]+"-"+aPRODUTO[n][2],;
						aViewCsm2[1][3],;
						aViewCsm2[2][3],;
						aViewCsm2[3][3],;
						aViewCsm2[4][3],;
						aViewCsm2[5][3],;
						aViewCsm2[6][3],;
						aViewCsm2[7][3],;
						aViewCsm2[8][3],;
						aViewCsm2[9][3],;
						aViewCsm2[10][3],;
						aViewCsm2[11][3],;
						aViewCsm2[12][3],;
						0,;
						0,;
						0,;
						aPRODUTO[n][1]})


						vTM1+=aViewCsm2[1][3]
						vTM2+=aViewCsm2[2][3]
						vTM3+=aViewCsm2[3][3]
						vTM4+=aViewCsm2[4][3]
						vTM5+=aViewCsm2[5][3]
						vTM6+=aViewCsm2[6][3]
						vTM7+=aViewCsm2[7][3]
						vTM8+=aViewCsm2[8][3]
						vTM9+=aViewCsm2[9][3]
						vTM10+=aViewCsm2[10][3]
						vTM11+=aViewCsm2[11][3]
						vTM12+=aViewCsm2[12][3]





						vM1  := aViewCsm2[1][1]+"/"+aViewCsm2[1][2]
						vM2  := aViewCsm2[2][1]+"/"+aViewCsm2[2][2]
						vM3  := aViewCsm2[3][1]+"/"+aViewCsm2[3][2]
						vM4  := aViewCsm2[4][1]+"/"+aViewCsm2[4][2]
						vM5  := aViewCsm2[5][1]+"/"+aViewCsm2[5][2]
						vM6  := aViewCsm2[6][1]+"/"+aViewCsm2[6][2]
						vM7  := aViewCsm2[7][1]+"/"+aViewCsm2[7][2]
						vM8  := aViewCsm2[8][1]+"/"+aViewCsm2[8][2]
						vM9  := aViewCsm2[9][1]+"/"+aViewCsm2[9][2]
						vM10 := aViewCsm2[10][1]+"/"+aViewCsm2[10][2]
						vM11 := aViewCsm2[11][1]+"/"+aViewCsm2[11][2]
						vM12 := aViewCsm2[12][1]+"/"+aViewCsm2[12][2]

					endif

				Next n


				tcSetConn(nHErp)

				For n:=1 to len(aViewCsm)



					_cQuery:=" SELECT B2_QATU"
					_cQuery+=" FROM SB2010 "
					_cQuery+=" WHERE B2_FILIAL = '"+_cFiref+"'"
					_cQuery+=" AND   B2_COD = '"+aViewCsm[n][17]+"' "
					_cQuery+=" AND   D_E_L_E_T_ = '' "
					_cQuery+=" AND   B2_LOCAL = '01' "
					dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),"TMP99",.T.,.T.)

					vEST := TMP99->B2_QATU
					TMP99->(DBCLOSEAREA())
					vTOTEST+=vEST
					//		aADD(aViewCsm2,{"ESTOQUE"," ",vEST})

					cQTDPED   := U_QTDPEDF(_cFiref,aViewCsm[n][17])
					vTM14+=cQTDPED
					TMP6->(DBCLOSEAREA())

					//        	aADD(aViewCsm2,{"PEDIDO"," ",cQTDPED})
					cQTDPNF   := U_QTDPNFF(_cFiref,aViewCsm[n][17])

					TMP7->(DBCLOSEAREA())
					vTPREN+=cQTDPNF

					//		 	aADD(aViewCsm2,{"PRE-NOTA"," ",cQTDPNF})


					aADD(aViewCsm3,{aViewCsm[n][1],;
					aViewCsm[n][2],;
					aViewCsm[n][3],;
					aViewCsm[n][4],;
					aViewCsm[n][5],;
					aViewCsm[n][6],;
					aViewCsm[n][7],;
					aViewCsm[n][8],;
					aViewCsm[n][9],;
					aViewCsm[n][10],;
					aViewCsm[n][11],;
					aViewCsm[n][12],;
					aViewCsm[n][13],;
					vEST,;
					cQTDPED,;
					cQTDPNF})


				next N


				aADD(aViewCsm3,{"TOTAL",;
				vTM1,;
				vTM2,;
				vTM3,;
				vTM4,;
				vTM5,;
				vTM6,;
				vTM7,;
				vTM8,;
				vTM9,;
				vTM10,;
				vTM11,;
				vTM12,;
				vTOTEST,;
				vTM14,;
				vTPREN})



				If !Empty(aViewCsm3)

					DEFINE FONT oBold NAME "Arial" SIZE 0, -12 BOLD
					//		DEFINE MSDIALOG oFolder1:aDialogs[5] FROM 0,0  TO 350,1220 TITLE STR0032 Of oMainWnd PIXEL //"Consumos"
					@ 13, 4 To 14,600 Label "" of oFolder1:aDialogs[5] PIXEL
					oListBox := TWBrowse():New( 20,4,600,160,,{"PRODUTO",vM1,;
					vM2,;
					vM3,;
					vM4,;
					vM5,;
					vM6,;
					vM7,;
					vM8,;
					vM9,;
					vM10,;
					vM11,;
					vM12,;
					"ESTOQUE",;
					"PEDIDO",;
					"PRE-NOTA"},{140,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30},oFolder1:aDialogs[5],,,,,,,,,,,,.F.,,.T.,,.F.,,,) //"Mes"###"Ano"###"Consumo"

					oListBox:SetArray(aViewCsm3)
					oListBox:bLine := { || {aViewCsm3[oListBox:nAT][1],;
					TransForm(aViewCsm3[oListBox:nAt][2],PesqPict("SB3","B3_Q01")),;
					TransForm(aViewCsm3[oListBox:nAt][3],PesqPict("SB3","B3_Q01")),;
					TransForm(aViewCsm3[oListBox:nAt][4],PesqPict("SB3","B3_Q01")),;
					TransForm(aViewCsm3[oListBox:nAt][5],PesqPict("SB3","B3_Q01")),;
					TransForm(aViewCsm3[oListBox:nAt][6],PesqPict("SB3","B3_Q01")),;
					TransForm(aViewCsm3[oListBox:nAt][7],PesqPict("SB3","B3_Q01")),;
					TransForm(aViewCsm3[oListBox:nAt][8],PesqPict("SB3","B3_Q01")),;
					TransForm(aViewCsm3[oListBox:nAt][9],PesqPict("SB3","B3_Q01")),;
					TransForm(aViewCsm3[oListBox:nAt][10],PesqPict("SB3","B3_Q01")),;
					TransForm(aViewCsm3[oListBox:nAt][11],PesqPict("SB3","B3_Q01")),;
					TransForm(aViewCsm3[oListBox:nAt][12],PesqPict("SB3","B3_Q01")),;
					TransForm(aViewCsm3[oListBox:nAt][13],PesqPict("SB3","B3_Q01")),;
					TransForm(aViewCsm3[oListBox:nAt][14],PesqPict("SB3","B3_Q01")),;
					TransForm(aViewCsm3[oListBox:nAt][15],PesqPict("SB3","B3_Q01")),;
					TransForm(aViewCsm3[oListBox:nAt][16],PesqPict("SB3","B3_Q01"))}}
					//	@ 4  ,10   SAY Alltrim(cProduto)+ " - "+SB1->B1_DESC Of oFolder1:aDialogs[5] PIXEL SIZE 245 ,9 FONT oBold


					//		@ 160 ,540  BUTTON STR0016 SIZE 45 ,10  FONT oFolder1:aDialogs[5]:oFont ACTION (oFolder1:aDialogs[5]:End())  OF oFolder1:aDialogs[5] PIXEL  //"Voltar"
					//		ACTIVATE MSDIALOG oDlg CENTERED
				Else
					Aviso(STR0014,STR0036,{STR0016},2) //"Atencao"###"Nao existe registros de consumo para este produto."###"Voltar"
				EndIf
			ENDIF

		EndIf
	Else


		aADD(aPRODUTO,{'',''})




		For n:=1  to len(aPRODUTO)
			//u_LinkEst()

			aViewCsm2	 := {}
			cMeses	:= SPACE(3)
			nAno	:= YEAR(dDataBase)
			nMes	:= MONTH(dDataBase)
			aOrdem	:= {}
			nAno--
			For nx := nMes+1 To 12
				//			aADD(aViewCsm,{aMeses[nx],Str(nAno,4),&("B3_Q"+StrZero(nx,2))})
				aADD(aViewCsm2,{aMeses[nx],Str(nAno,4),0,aPRODUTO[n][1]})
			Next nx
			nAno++
			For nx	:= 1 to nMes
				//			aADD(aViewCsm,{aMeses[nx],Str(nAno,4),&("B3_Q"+StrZero(nx,2))})
				aADD(aViewCsm2,{aMeses[nx],Str(nAno,4),0,aPRODUTO[n][1]})
			Next nx

			if aViewCsm2 <> {}
				aADD(aViewCsm,{aPRODUTO[n][1]+"-"+aPRODUTO[n][2],;
				aViewCsm2[1][3],;
				aViewCsm2[2][3],;
				aViewCsm2[3][3],;
				aViewCsm2[4][3],;
				aViewCsm2[5][3],;
				aViewCsm2[6][3],;
				aViewCsm2[7][3],;
				aViewCsm2[8][3],;
				aViewCsm2[9][3],;
				aViewCsm2[10][3],;
				aViewCsm2[11][3],;
				aViewCsm2[12][3],;
				0,;
				0,;
				0,;
				aPRODUTO[n][1]})


				vTM1+=aViewCsm2[1][3]
				vTM2+=aViewCsm2[2][3]
				vTM3+=aViewCsm2[3][3]
				vTM4+=aViewCsm2[4][3]
				vTM5+=aViewCsm2[5][3]
				vTM6+=aViewCsm2[6][3]
				vTM7+=aViewCsm2[7][3]
				vTM8+=aViewCsm2[8][3]
				vTM9+=aViewCsm2[9][3]
				vTM10+=aViewCsm2[10][3]
				vTM11+=aViewCsm2[11][3]
				vTM12+=aViewCsm2[12][3]





				vM1  := aViewCsm2[1][1]+"/"+aViewCsm2[1][2]
				vM2  := aViewCsm2[2][1]+"/"+aViewCsm2[2][2]
				vM3  := aViewCsm2[3][1]+"/"+aViewCsm2[3][2]
				vM4  := aViewCsm2[4][1]+"/"+aViewCsm2[4][2]
				vM5  := aViewCsm2[5][1]+"/"+aViewCsm2[5][2]
				vM6  := aViewCsm2[6][1]+"/"+aViewCsm2[6][2]
				vM7  := aViewCsm2[7][1]+"/"+aViewCsm2[7][2]
				vM8  := aViewCsm2[8][1]+"/"+aViewCsm2[8][2]
				vM9  := aViewCsm2[9][1]+"/"+aViewCsm2[9][2]
				vM10 := aViewCsm2[10][1]+"/"+aViewCsm2[10][2]
				vM11 := aViewCsm2[11][1]+"/"+aViewCsm2[11][2]
				vM12 := aViewCsm2[12][1]+"/"+aViewCsm2[12][2]

			endif

		Next n


		tcSetConn(nHErp)

		For n:=1 to len(aViewCsm)



			_cQuery:=" SELECT B2_QATU"
			_cQuery+=" FROM SB2010 "
			_cQuery+=" WHERE B2_FILIAL = '"+_cFiref+"'"
			_cQuery+=" AND   B2_COD = '"+aViewCsm[n][17]+"' "
			_cQuery+=" AND   D_E_L_E_T_ = '' "
			_cQuery+=" AND   B2_LOCAL = '01' "
			dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),"TMP99",.T.,.T.)

			vEST := TMP99->B2_QATU
			TMP99->(DBCLOSEAREA())
			vTOTEST+=vEST
			//		aADD(aViewCsm2,{"ESTOQUE"," ",vEST})

			cQTDPED   := U_QTDPEDF(_cFiref,aViewCsm[n][17])
			vTM14+=cQTDPED
			TMP6->(DBCLOSEAREA())

			//        	aADD(aViewCsm2,{"PEDIDO"," ",cQTDPED})
			cQTDPNF   := U_QTDPNFF(_cFiref,aViewCsm[n][17])

			TMP7->(DBCLOSEAREA())
			vTPREN+=cQTDPNF

			//		 	aADD(aViewCsm2,{"PRE-NOTA"," ",cQTDPNF})


			aADD(aViewCsm3,{aViewCsm[n][1],;
			aViewCsm[n][2],;
			aViewCsm[n][3],;
			aViewCsm[n][4],;
			aViewCsm[n][5],;
			aViewCsm[n][6],;
			aViewCsm[n][7],;
			aViewCsm[n][8],;
			aViewCsm[n][9],;
			aViewCsm[n][10],;
			aViewCsm[n][11],;
			aViewCsm[n][12],;
			aViewCsm[n][13],;
			vEST,;
			cQTDPED,;
			cQTDPNF})


		next N


		aADD(aViewCsm3,{"TOTAL",;
		vTM1,;
		vTM2,;
		vTM3,;
		vTM4,;
		vTM5,;
		vTM6,;
		vTM7,;
		vTM8,;
		vTM9,;
		vTM10,;
		vTM11,;
		vTM12,;
		vTOTEST,;
		vTM14,;
		vTPREN})



		If !Empty(aViewCsm3)
			DEFINE FONT oBold NAME "Arial" SIZE 0, -12 BOLD
			//		DEFINE MSDIALOG oFolder1:aDialogs[5] FROM 0,0  TO 350,1220 TITLE STR0032 Of oMainWnd PIXEL //"Consumos"
			@ 13, 4 To 14,600 Label "" of oFolder1:aDialogs[5] PIXEL
			oListBox := TWBrowse():New( 20,4,600,160,,{"PRODUTO",vM1,;
			vM2,;
			vM3,;
			vM4,;
			vM5,;
			vM6,;
			vM7,;
			vM8,;
			vM9,;
			vM10,;
			vM11,;
			vM12,;
			"ESTOQUE",;
			"PEDIDO",;
			"PRE-NOTA"},{140,30,30,30,30,30,30,30,30,30,30,30,30,30,30,30},oFolder1:aDialogs[5],,,,,,,,,,,,.F.,,.T.,,.F.,,,) //"Mes"###"Ano"###"Consumo"
			oListBox:SetArray(aViewCsm3)
			oListBox:bLine := { || {aViewCsm3[oListBox:nAT][1],;
			TransForm(aViewCsm3[oListBox:nAt][2],PesqPict("SB3","B3_Q01")),;
			TransForm(aViewCsm3[oListBox:nAt][3],PesqPict("SB3","B3_Q01")),;
			TransForm(aViewCsm3[oListBox:nAt][4],PesqPict("SB3","B3_Q01")),;
			TransForm(aViewCsm3[oListBox:nAt][5],PesqPict("SB3","B3_Q01")),;
			TransForm(aViewCsm3[oListBox:nAt][6],PesqPict("SB3","B3_Q01")),;
			TransForm(aViewCsm3[oListBox:nAt][7],PesqPict("SB3","B3_Q01")),;
			TransForm(aViewCsm3[oListBox:nAt][8],PesqPict("SB3","B3_Q01")),;
			TransForm(aViewCsm3[oListBox:nAt][9],PesqPict("SB3","B3_Q01")),;
			TransForm(aViewCsm3[oListBox:nAt][10],PesqPict("SB3","B3_Q01")),;
			TransForm(aViewCsm3[oListBox:nAt][11],PesqPict("SB3","B3_Q01")),;
			TransForm(aViewCsm3[oListBox:nAt][12],PesqPict("SB3","B3_Q01")),;
			TransForm(aViewCsm3[oListBox:nAt][13],PesqPict("SB3","B3_Q01")),;
			TransForm(aViewCsm3[oListBox:nAt][14],PesqPict("SB3","B3_Q01")),;
			TransForm(aViewCsm3[oListBox:nAt][15],PesqPict("SB3","B3_Q01")),;
			TransForm(aViewCsm3[oListBox:nAt][16],PesqPict("SB3","B3_Q01"))}}
			@ 4  ,10   SAY Alltrim(_cCod)+ " - "+_cDescri Of oFolder1:aDialogs[5] PIXEL SIZE 245 ,9 FONT oBold


			//		@ 160 ,540  BUTTON STR0016 SIZE 45 ,10  FONT oFolder1:aDialogs[5]:oFont ACTION (oFolder1:aDialogs[5]:End())  OF oFolder1:aDialogs[5] PIXEL  //"Voltar"
			//		ACTIVATE MSDIALOG oDlg CENTERED
		Else
			Aviso(STR0014,STR0036,{STR0016},2) //"Atencao"###"Nao existe registros de consumo para este produto."###"Voltar"
		EndIf
	EndIf
Return Nil

Static Function CON2(cANOMES,cCOD,cFILIAL,vTIPO)


	_cQuery2:= " SELECT SUM(ZN_VENQTD-ZN_DEVQTDV) AS CONSU"
	_cQuery2+= " FROM  SZNMENSAL"
	_cQuery2+= " WHERE ZN_FILIAL = '"+cFILIAL+"'"
	_cQuery2+= " AND   ZN_PRODUTO = '"+cCOD+"'"
	_cQuery2+= " AND   ZN_ANOMES = '"+cANOMES+"' "
	dbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery2),"TRA",.T.,.T.)

	vRET:=0

	vRET := TRA->CONSU

	TRA->(DBCLOSEAREA())


return vRET
