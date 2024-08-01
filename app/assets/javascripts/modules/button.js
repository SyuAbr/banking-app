export function createButton(text, onClick) {
    const button = document.createElement('button');
    button.innerText = text;
    button.style.fontFamily = 'Courier New, Courier, monospace';
    button.style.fontSize = '14pt';
    button.style.backgroundColor = 'blue';
    button.style.color = 'white';
    button.style.padding = '10px';
    button.style.position = 'fixed';
    button.style.bottom = '10px';
    button.style.right = '10px';
    button.style.borderRadius = '5px';
    button.style.cursor = 'pointer';
    button.style.border = 'none';
    button.addEventListener('click', onClick);
    return button;
};
export function createCloseButton(onClick) {
    const closeButton = document.createElement('span');
    closeButton.innerText = '×';
    Object.assign(closeButton.style, {
        position: 'absolute',
        top: '5px',
        right: '10px',
        cursor: 'pointer'
    });
    closeButton.addEventListener('click', onClick);
    return closeButton;
}