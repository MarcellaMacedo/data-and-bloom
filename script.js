
// ==========================================
// DATA & BLOOM — JAVASCRIPT
// ==========================================


// 01. NAVEGAÇÃO SUAVE

document.querySelectorAll('a[href^="#"]').forEach(link => {

    link.addEventListener('click', function(event) {

        const destino = document.querySelector(this.getAttribute('href'));

        if (destino) {
            event.preventDefault();

            destino.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }

    });

});


// ==========================================
// 02. ANO AUTOMÁTICO NO COPYRIGHT
// ==========================================

const anoAtual = new Date().getFullYear();

const elementoAno = document.getElementById('current-year');

if (elementoAno) {
    elementoAno.textContent = anoAtual;
}



// ==========================================
// 03. BOTÃO VOLTAR AO TOPO
// ==========================================

const botaoTopo = document.createElement('button');

botaoTopo.type = 'button';
botaoTopo.className = 'botao-voltar-topo';
botaoTopo.setAttribute('aria-label', 'Voltar ao topo');
botaoTopo.innerHTML = '<span aria-hidden="true">↑</span>';

// Adiciona o botão à página
document.body.appendChild(botaoTopo);

// Mostra o botão depois que o usuário rolar a página
window.addEventListener('scroll', () => {
    if (window.scrollY > 300) {
        botaoTopo.classList.add('visivel');
    } else {
        botaoTopo.classList.remove('visivel');
    }
});

// Retorna suavemente ao início da página
botaoTopo.addEventListener('click', () => {
    window.scrollTo({
        top: 0,
        behavior: 'smooth'
    });
});
