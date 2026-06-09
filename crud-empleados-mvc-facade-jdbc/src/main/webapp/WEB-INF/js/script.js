// ===== SLIDER =====
const slides = document.querySelectorAll('.slide');
const dots   = document.querySelectorAll('.dot');
const pauseBtn = document.querySelector('.pause-btn');
let current = 0;
let paused  = false;
let timer;

function showSlide(n) {
    slides.forEach(s => s.classList.remove('active'));
    dots.forEach(d => d.classList.remove('active'));
    current = (n + slides.length) % slides.length;
    if (slides[current]) slides[current].classList.add('active');
    if (dots[current])   dots[current].classList.add('active');
}

function nextSlide() { showSlide(current + 1); }

function startTimer() {
    clearInterval(timer);
    if (!paused) timer = setInterval(nextSlide, 4000);
}

dots.forEach((dot, i) => dot.addEventListener('click', () => { showSlide(i); startTimer(); }));

pauseBtn?.addEventListener('click', () => {
    paused = !paused;
    pauseBtn.textContent = paused ? '▶' : '⏸';
    startTimer();
});

startTimer();

// ===== DROPDOWN ACCESSIBILITY (keyboard) =====
document.querySelectorAll('.nav-btn').forEach(btn => {
    btn.addEventListener('keydown', e => {
        if (e.key === 'Enter' || e.key === ' ') {
            const menu = btn.nextElementSibling;
            if (menu) {
                menu.style.display = menu.style.display === 'block' ? 'none' : 'block';
            }
        }
    });
});

// ===== CARD HOVER GLOW =====
document.querySelectorAll('.course-card').forEach(card => {
    card.addEventListener('mousemove', e => {
        const rect = card.getBoundingClientRect();
        const x = ((e.clientX - rect.left) / rect.width)  * 100;
        const y = ((e.clientY - rect.top)  / rect.height) * 100;
        card.style.setProperty('--mx', x + '%');
        card.style.setProperty('--my', y + '%');
    });
});
