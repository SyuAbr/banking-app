import { createButton, createCloseButton } from './modules/button.js';
import { createModal } from './modules/modal.js';
import { searchTicker } from './modules/search.js';
document.addEventListener('DOMContentLoaded', function() {
    setTimeout(() => {

        const searchButton = createButton('Поиск', () => {
            searchButton.style.display = 'none';
            searchModal.style.display = 'block';
        });
        searchButton.id= 'searchButton'
        document.body.appendChild(searchButton);

        const { searchModal, searchInput, resultList } = createModal();
        document.body.appendChild(searchModal);

        const closeButton = createCloseButton(() => {
            searchModal.style.display = 'none';
            searchButton.style.display = 'block';
        });
        searchModal.appendChild(closeButton);


        function updateResults() {
            const query = searchInput.value;
            const results = searchTicker(query);
            resultList.innerHTML = '';
            results.forEach(ticker => {
                const listItem = document.createElement('li');
                listItem.innerText = ticker;
                resultList.appendChild(listItem);
            });
        }

        searchInput.addEventListener('input', updateResults);
        updateResults();
    }, 5000);
});
