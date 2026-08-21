document.addEventListener('DOMContentLoaded', () => {
    const searchInput = document.getElementById('search-input');
    const filterButtons = document.querySelectorAll('.filter-btn');
    const talkCards = document.querySelectorAll('.timeline-card');
    const noResults = document.getElementById('no-results');
    const clearFiltersBtn = document.getElementById('clear-filters-btn');

    let currentSearchQuery = '';
    let currentCategory = '0'; // '0' means 'All'

    // Main filter function
    function applyFilters() {
        let visibleCount = 0;

        talkCards.forEach(card => {
            const cardId = card.getAttribute('data-id');
            const cardCategory = card.getAttribute('data-category');
            
            // Text search data
            const title = card.querySelector('.talk-title')?.textContent.toLowerCase() || '';
            const description = card.querySelector('.talk-description')?.textContent.toLowerCase() || '';
            
            // Speaker names search
            const speakerNames = Array.from(card.querySelectorAll('.speaker-name'))
                .map(el => el.textContent.toLowerCase())
                .join(' ');

            const matchesSearch = currentSearchQuery === '' || 
                                  title.includes(currentSearchQuery) || 
                                  description.includes(currentSearchQuery) || 
                                  speakerNames.includes(currentSearchQuery);

            // Category match (Special rule: Lunch break (id 99) stays visible on category filter, but is subject to search filter)
            const matchesCategory = currentCategory === '0' || 
                                    cardCategory === currentCategory || 
                                    cardId === '99';

            if (matchesSearch && matchesCategory) {
                card.classList.remove('hidden');
                // Apply a subtle fade-in transition
                card.style.opacity = '0';
                setTimeout(() => {
                    card.style.transition = 'opacity 0.4s ease, transform 0.3s ease';
                    card.style.opacity = '1';
                }, 10);
                visibleCount++;
            } else {
                card.classList.add('hidden');
            }
        });

        // Toggle No Results card
        if (visibleCount === 0) {
            noResults.classList.remove('hidden');
        } else {
            noResults.classList.add('hidden');
        }
    }

    // Input Search Listener with Debounce
    let searchDebounceTimeout;
    searchInput.addEventListener('input', (e) => {
        clearTimeout(searchDebounceTimeout);
        searchDebounceTimeout = setTimeout(() => {
            currentSearchQuery = e.target.value.toLowerCase().trim();
            applyFilters();
        }, 150);
    });

    // Category Buttons Listener
    filterButtons.forEach(btn => {
        btn.addEventListener('click', () => {
            // Toggle active classes
            filterButtons.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');

            currentCategory = btn.getAttribute('data-category');
            applyFilters();
        });
    });

    // Clear filters button helper
    function resetAll() {
        searchInput.value = '';
        currentSearchQuery = '';
        
        // Reset category buttons
        filterButtons.forEach(b => b.classList.remove('active'));
        const allBtn = document.querySelector('.filter-btn[data-category="0"]');
        if (allBtn) allBtn.classList.add('active');
        
        currentCategory = '0';
        applyFilters();
    }

    clearFiltersBtn.addEventListener('click', resetAll);
});
