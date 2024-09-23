<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeBehind="Default.aspx.cs" Inherits="MAPA_SVG._Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Content" runat="server">
    <div class="container">
        <div class="mosaico">
                   <!-- Botón para regresar al mapa original -->
       <button id="regresarBtn"  >
           Regresar al mapa
       </button>
            <!-- Object donde se cargará el SVG -->
            <object id="svgMap" type="image/svg+xml" data="../assetts/mapnotit.svg" width="100%" height="500px" style="padding: 1%">
                <!-- Mensaje alternativo para navegadores que no soportan SVG -->
                Tu navegador no soporta SVG
            </object>
        </div>
        <div id="sectionLabel" class="section-label"></div>
        <!-- Aquí se mostrará el nombre de la sección -->

 
    </div>

    <style>
        /* Estilo de transición para suavizar el agrandamiento */
        .transition {
            transition: transform 0.3s ease-out;
        }

        /* Estilos para el texto flotante que muestra el nombre de la sección */
        .section-label {
            position: absolute;
            background-color: rgba(0, 0, 0, 0.7);
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 4dvh;
            display: none;
            pointer-events: none;
            z-index: 1000;
        }

        .mosaico {
            width: 100%;
            height: 500px;
            background-position: 0 0, 0 20px, 20px -20px, -20px 0px; /* Ajuste del patrón */
        }
    </style>

    <script type="text/javascript">
        document.addEventListener("DOMContentLoaded", function () {
            var svgObject = document.getElementById("svgMap");
            var sectionLabel = document.getElementById("sectionLabel"); // El div que mostrará el nombre de la sección
            var regresarBtn = document.getElementById("regresarBtn"); // El botón para regresar al mapa

            // Asignar nombres personalizados a cada sección del SVG
            var sectionNames = {
                seccion1: "Sección: Inyección",
                seccion2: "Sección: Moldura",
                seccion3: "Sección: Ensamble",
                seccion4: "Sección: Pintura",
                seccion5: "Sección: Retrabajo",
                seccion6: "Sección: Empaque"
            };

            // Archivos SVG que se cargarán al hacer clic en cada sección
            var sectionSVGs = {
                seccion1: "../assetts/detalle1.svg",
                seccion2: "../assetts/detalle2.svg",
                seccion3: "../assetts/detalle3.svg",
                seccion4: "../assetts/detalle4.svg",
                seccion5: "../assetts/detalle5.svg",
                seccion6: "../assetts/detalle6.svg"
            };

            // Esperar a que se cargue el contenido del SVG
            svgObject.addEventListener("load", function () {
                var svgDoc = svgObject.contentDocument;

                if (!svgDoc) {
                    console.error("Error: No se puede acceder al documento SVG");
                    return;
                }

                // Identificar las secciones por ID dentro del SVG
                var secciones = [
                    svgDoc.getElementById("seccion1"),
                    svgDoc.getElementById("seccion2"),
                    svgDoc.getElementById("seccion3"),
                    svgDoc.getElementById("seccion4"),
                    svgDoc.getElementById("seccion5"),
                    svgDoc.getElementById("seccion6")
                ];

                // Asignar eventos a cada sección
                secciones.forEach(function (seccion) {
                    if (seccion) {
                        // Agregar clase de transición para suavizar el agrandamiento
                        seccion.classList.add("transition");

                        // Al pasar el mouse, agrandar la sección y mostrar el nombre personalizado
                        seccion.addEventListener("mouseover", function (event) {
                            var sectionId = seccion.id;
                            sectionLabel.textContent = sectionNames[sectionId] || "Sección desconocida"; // Mostrar el nombre personalizado
                            sectionLabel.style.display = 'block'; // Mostrar el label
                            seccion.style.transform = "scale(1.1)"; // Escalar un 10% más grande
                        });

                        // Al mover el mouse, actualizar la posición del texto
                        seccion.addEventListener("mousemove", function (event) {
                            sectionLabel.style.left = event.clientX + window.scrollX + 130 + 'px';
                            sectionLabel.style.top = event.clientY + window.scrollY - -65 + 'px';
                        });

                        // Al quitar el mouse, restaurar el tamaño y ocultar el texto
                        seccion.addEventListener("mouseout", function () {
                            sectionLabel.style.display = 'none'; // Ocultar el label
                            seccion.style.transform = "scale(1)"; // Volver al tamaño original
                        });

                        // Al hacer clic en la sección, cargar otro SVG
                        seccion.addEventListener("click", function () {
                            var newSvgPath = sectionSVGs[seccion.id]; // Obtener la ruta del nuevo SVG
                            if (newSvgPath) {
                                cargarNuevoSVG(newSvgPath); // Cargar el nuevo SVG
                                regresarBtn.style.display = 'block'; // Mostrar el botón para regresar al mapa original
                            }
                        });
                    }
                });
            });

            // Función para cargar un nuevo SVG en el <object>
            function cargarNuevoSVG(svgPath) {
                svgObject.setAttribute("data", svgPath); // Reemplazar el SVG actual con otro
                svgObject.addEventListener("load", function () {
                    var newSvgDoc = svgObject.contentDocument;

                    if (!newSvgDoc) {
                        console.error("Error: No se puede acceder al nuevo SVG");
                        return;
                    }

                    // Asignar comportamiento al nuevo SVG cargado
                    newSvgDoc.addEventListener("click", function () {
                        alert("Hiciste clic en el nuevo SVG"); // Puedes cambiar esta acción
                    });
                });
            }

            // Función para regresar al mapa original
            regresarBtn.addEventListener("click", function () {
                svgObject.setAttribute("data", "../assetts/mapnotit.svg"); // Regresar al mapa original
                regresarBtn.style.display = 'none';
                return false// Ocultar el botón de regreso
            });
        });
    </script>
</asp:Content>
