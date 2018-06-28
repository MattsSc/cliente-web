$(window).on("load", GetAllPedidos);

function GetAllPedidos(){
    $.ajax({
        type: "GET",
        url: "/Cliente",
        success: function(pedidos){
            var cantRecibido = pedidos.filter(pedido => pedido.estado == "RECIBIDO").length;
            var cantAprob = pedidos.filter(pedido => pedido.estado === "DESPACHABLE").length;
            var cantFaltaStock = pedidos.filter(pedido => pedido.estado === "FALTA_STOCK").length;
            var cantRech = pedidos.filter(pedido => pedido.estado === "RECHAZADO").length;
            var cantCompleto = pedidos.filter(pedido => pedido.estado === "COMPLETO").length;
            var ctx = document.getElementById("myChart").getContext('2d');
            var myChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ["Recibido", "Aprobado", "Falta Stock", "Rechazado", "Completo"],
                    datasets: [{
                        label: '# de pedidos',
                        data: [cantRecibido,cantAprob,cantFaltaStock,cantRech,cantCompleto],
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)',
                            'rgba(255, 206, 86, 0.2)',
                            'rgba(75, 192, 192, 0.2)',
                            'rgba(153, 102, 255, 0.2)'
                        ],
                        borderColor: [
                            'rgba(255,99,132,1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero:true,
                                stepSize: 1
                            }
                        }]
                    }
                }
            });
        }
    });
}