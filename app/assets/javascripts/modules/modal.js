export function createModal() {
    const searchModal = document.createElement('div');
    searchModal.id = 'searchModal';
    searchModal.style.display = 'none';
    Object.assign(searchModal.style, {
        position: 'fixed',
        bottom: '10px',
        right: '10px',
        padding: '20px',
        backgroundColor: 'white',
        border: '1px solid #ccc',
        borderRadius: '5px',
        boxShadow: '0 2px 10px rgba(0, 0, 0, 0.1)'
    });

    const searchInput = document.createElement('input');
    Object.assign(searchInput.style, {
        display: 'block',
        width: '100%',
        padding: '10px',
        marginBottom: '10px',
        fontFamily: 'Courier New, Courier, monospace',
        fontSize: '14pt',
        border: '1px solid #ccc',
        borderRadius: '5px'
    });
    searchModal.appendChild(searchInput);

    const resultList = document.createElement('ul');
    resultList.id = 'resultList';
    Object.assign(resultList.style, {
        listStyle: 'none',
        padding: '0',
        fontFamily: 'Courier New, Courier, monospace',
        fontSize: '14pt'
    });
    searchModal.appendChild(resultList);

    return { searchModal, searchInput, resultList };
}
