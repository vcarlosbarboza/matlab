# Simulación del Crecimiento Poblacional en Italia (2019–2034)
##  Basado en un Modelo Logístico con Analogía Masa-Resorte-Amortiguador

Este proyecto simula el comportamiento poblacional de Italia entre 2019 y 2034 utilizando un **modelo logístico de crecimiento** y lo interpreta mediante una analogía con un **sistema masa–resorte–amortiguador**.

---

## ¿Qué hace este código?

- Toma datos reales de población de Italia (2019–2023).
- Ajusta un modelo logístico con parámetros calibrados:
  - **P₀**: población inicial
  - **r**: tasa de crecimiento (negativa en este caso)
  - **K**: capacidad de carga
- Simula la evolución futura de la población hasta el año 2034.
- Grafica el ajuste histórico y las proyecciones.
- Calcula errores, tasas de cambio y variación porcentual.
- Presenta una interpretación **física y conceptual** del modelo, usando analogías con la dinámica de sistemas mecánicos.

---

##  Requisitos

- MATLAB 

---

##  ¿Qué representa cada parte?

| Componente del modelo | Significado                         | Analogía física                 |
|-----------------------|-------------------------------------|----------------------------------|
| `P(t)`                | Población en el tiempo              | Desplazamiento de la masa       |
| `r`                   | Tasa de crecimiento (negativa)      | Constante del resorte (k)       |
| `K`                   | Capacidad de carga poblacional      | Amortiguador (b)                |

---

##  ¿Por qué usar la analogía masa–resorte?

Aunque el modelo logístico es de primer orden, se puede **interpretar conceptualmente** como un sistema físico amortiguado:
- La **población oscila hacia un equilibrio** (K), al igual que una masa vuelve a su posición de reposo.
- El **crecimiento se frena** a medida que se acerca al límite, como lo haría un amortiguador.

---

##  Salidas del script

- **Gráfica de población real vs simulada**
- **Predicción extendida a 15 años**
- **Gráfica de tasa de cambio dP/dt**
- **Tabla de resultados y errores**
- **Interpretación física del modelo**
- **Predicciones por quinquenios**

---

