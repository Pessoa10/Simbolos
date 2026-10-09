#Requires AutoHotkey v2.0

; ===================================================================
; Atalho para ativar: Win + Alt + .
; ===================================================================

; ===== MENU ÚNICO =====
MainMenu := Menu()

; --- TEXTO ---
MainMenu.Add("Converter para MAIÚSCULO", ToUpper)
MainMenu.Add("Converter para minúsculo", ToLower)

; --- LINHA SEPARADORA ---
MainMenu.Add()

; --- SÍMBOLOS MATEMÁTICOS ---
MainMenu.Add("√ (raiz)", Inserir)
MainMenu.Add("≅ (congruente)", Inserir)
MainMenu.Add("± (mais ou menos)", Inserir)
MainMenu.Add("∠ (ângulo)", Inserir)
MainMenu.Add("∞ (infinito)", Inserir)
MainMenu.Add("≤ (menor ou igual)", Inserir)
MainMenu.Add("≥ (maior ou igual)", Inserir)
MainMenu.Add("× (multiplicação)", Inserir)
MainMenu.Add("÷ (divisão)", Inserir)

; --- LINHA SEPARADORA ---
MainMenu.Add()

; --- LETRAS GREGAS ---
MainMenu.Add("α (alfa)", Inserir)
MainMenu.Add("β (beta)", Inserir)
MainMenu.Add("γ (gama)", Inserir)

; ===================================================================
; OBSERVAÇÃO IMPORTANTE (NÃO APAGAR):
; As letras maiúsculas (Γ, Δ, Π, Σ, Ω) precisam usar Chr(0x00A0) 
; que é um "Espaço Inseparável" (Alt+0160), porque o AutoHotkey v2 
; corta o texto do menu se houver um espaço normal entre o símbolo 
; e o parêntese. Esse comando garante que o menu mostre o texto 
; completo e a função consiga capturar o símbolo corretamente.
; ===================================================================

MainMenu.Add("Γ" Chr(0x00A0) "(Gama)", Inserir)
MainMenu.Add("δ (delta)", Inserir)
MainMenu.Add("Δ" Chr(0x00A0) "(Delta)", Inserir)
MainMenu.Add("ε (épsilon)", Inserir)
MainMenu.Add("ζ (zeta)", Inserir)
MainMenu.Add("η (eta)", Inserir)
MainMenu.Add("θ (teta)", Inserir)
MainMenu.Add("λ (lambda)", Inserir)
MainMenu.Add("μ (micro)", Inserir)
MainMenu.Add("ξ (csi)", Inserir)
MainMenu.Add("π (pi)", Inserir)
MainMenu.Add("Π" Chr(0x00A0) "(Pi)", Inserir)
MainMenu.Add("ρ (rô)", Inserir)
MainMenu.Add("σ (sigma)", Inserir)
MainMenu.Add("Σ" Chr(0x00A0) "(Sigma)", Inserir)
MainMenu.Add("τ (tau)", Inserir)
MainMenu.Add("ω (ômega)", Inserir)
MainMenu.Add("Ω" Chr(0x00A0) "(Ohm)", Inserir)

; ===== HOTKEY =====
#!.:: {
    MainMenu.Show()
}

; ===== FUNÇÕES =====
ToUpper(*) {
    ConvertText("upper")
}

ToLower(*) {
    ConvertText("lower")
}

ConvertText(mode) {
    ClipSaved := ClipboardAll()
    A_Clipboard := ""

    SendEvent "{Ctrl down}c{Ctrl up}"
    Sleep 150

    if A_Clipboard = "" {
        A_Clipboard := ClipSaved
        return
    }

    if (mode = "upper")
        A_Clipboard := StrUpper(A_Clipboard)
    else
        A_Clipboard := StrLower(A_Clipboard)

    SendEvent "{Ctrl down}v{Ctrl up}"
    Sleep 50
    A_Clipboard := ClipSaved
}

; ===== FUNÇÃO QUE CAPTURA O SÍMBOLO CORRETAMENTE =====
Inserir(ItemName, *) {
    ; Procura onde está o primeiro parêntese "("
    pos := InStr(ItemName, "(")
    
    if (pos > 0) {
        ; Se encontrar o parêntese, pega tudo o que está ANTES dele e remove espaços sobrando
        symbol := Trim(SubStr(ItemName, 1, pos - 1))
    } else {
        ; Caso não tenha parênteses no texto, separa pelo primeiro espaço normal
        symbol := StrSplit(ItemName, " ")[1]
    }
    
    ; Digita o símbolo
    SendInput symbol
}