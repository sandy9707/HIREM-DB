document.addEventListener('DOMContentLoaded', function() {
    const scrollUp = document.getElementById('scrollUp');
    const scrollDown = document.getElementById('scrollDown');
    const pages = document.querySelectorAll('.page');
    let currentPage = 0;
    
    // 向上滚动按钮点击事件
    scrollUp.addEventListener('click', function() {
        if (currentPage > 0) {
            currentPage--;
            const targetPosition = currentPage * window.innerHeight;
            window.scrollTo({
                top: targetPosition,
                behavior: 'smooth'
            });
        }
    });
    
    // 向下滚动按钮点击事件
    scrollDown.addEventListener('click', function() {
        if (currentPage < pages.length - 1) {
            currentPage++;
            const targetPosition = currentPage * window.innerHeight;
            window.scrollTo({
                top: targetPosition,
                behavior: 'smooth'
            });
        }
    });
    
    // 监听滚动事件来更新当前页面索引
    window.addEventListener('scroll', function() {
        const pageHeight = window.innerHeight;
        currentPage = Math.floor(window.scrollY / pageHeight);
        
        // 控制按钮显示
        scrollUp.style.display = currentPage > 0 ? 'block' : 'none';
        scrollDown.style.display = currentPage < pages.length - 1 ? 'block' : 'none';
    });
}); 