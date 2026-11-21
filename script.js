
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