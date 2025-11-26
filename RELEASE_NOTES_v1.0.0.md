# 📱 SSS Kronos Mobile v1.0.0

## 🎉 Primera Versión de Producción

Esta es la primera versión estable de SSS Kronos Mobile, lista para ser utilizada en producción.

## ✨ Funcionalidades Principales

### 🔐 Autenticación y Seguridad
- ✅ Sistema de login completo con Supabase
- ✅ Sistema de permisos por roles (Admin, Gestión, Jefe)
- ✅ Onboarding interactivo para nuevos usuarios
- ✅ Sesión persistente

### 📋 Gestión de Hojas de Ruta
- ✅ Visualización de hojas de ruta en tiempo real
- ✅ Gestión completa de checklist de servicio
  - Categorías: Comedor, Cocina, Almacén, Catering, Otros
  - Sistema de prioridades (Alta, Media, Baja)
  - Estados: Pendiente, En Proceso, Completado
- ✅ Registro de notas y observaciones
- ✅ Gestión de horarios de entrada/salida
- ✅ Control de material necesario
- ✅ Gestión de menús y bebidas
- ✅ Confirmación digital con firma
- ✅ Bloqueo automático después de confirmar
- ✅ Histórico completo de hojas de ruta

### 🔄 Sincronización
- ✅ Sincronización en tiempo real con la aplicación Desktop
- ✅ Actualización automática de datos
- ✅ Notificaciones de cambios

### 🎨 Interfaz de Usuario
- ✅ Diseño moderno y limpio
- ✅ Modo claro y oscuro
- ✅ Responsive para diferentes tamaños de pantalla
- ✅ Animaciones fluidas
- ✅ AppBar con degradado personalizado

### ⚙️ Configuración y Ajustes
- ✅ Pantalla de ajustes completa
- ✅ Verificación de estado de conexiones (Supabase, Holded)
- ✅ **Detector de actualizaciones desde GitHub**
- ✅ Información de versión de la app
- ✅ Perfil de usuario

## 🔧 Requisitos Técnicos

- **Sistema Operativo:** Android 8.0 (API 26) o superior
- **Arquitectura:** ARM64 (mayoría de dispositivos modernos)
- **Espacio en Disco:** ~100 MB libres
- **Conexión a Internet:** Requerida para sincronización con Supabase
- **Permisos Necesarios:**
  - 📷 Cámara (para captura de firma)
  - 📁 Almacenamiento (para archivos adjuntos)
  - 🌐 Internet (para sincronización)

## 📥 Instalación

### Paso 1: Descargar la APK
Descarga el archivo `SSS-Kronos-Mobile-v1.0.0.apk` desde los assets de esta release.

### Paso 2: Permitir instalación de fuentes desconocidas
En tu dispositivo Android:
1. Ve a **Ajustes → Seguridad/Privacidad → Instalar apps desconocidas**
2. Selecciona el navegador o gestor de archivos que uses
3. Activa **"Permitir"**

### Paso 3: Instalar
1. Abre el archivo APK descargado
2. Si aparece una advertencia de Play Protect, pulsa **"Más detalles" → "Instalar de todos modos"**
3. Toca **"Instalar"**

### Paso 4: Iniciar sesión
1. Abre **"SSS Kronos Mobile"**
2. Inicia sesión con tus credenciales proporcionadas por el administrador
3. Si es tu primera vez, completa el tutorial inicial

## 🔄 Actualización desde versiones anteriores

Esta es la primera versión estable. Las futuras actualizaciones se notificarán automáticamente desde la app:
- Ve a **⚙️ Ajustes → Verificar actualización**
- La app te informará si hay nuevas versiones disponibles

## 🐛 Problemas Conocidos

Ninguno reportado en esta versión.

## 📝 Notas Técnicas

- **Framework:** Flutter 3.9+
- **Backend:** Supabase
- **Base de Datos:** PostgreSQL (Supabase)
- **Autenticación:** Supabase Auth
- **Tamaño del APK:** 51 MB

## 🔗 Enlaces Útiles

- 📖 [Manual de Usuario](https://docs.google.com/document/d/1VyEojHDf-NtNp4Ufff_hr-TpM_tW7enjEtEMNN7hdHk/edit?usp=sharing)
- 📂 [Repositorio GitHub](https://github.com/Marcausente/Solucions-Socials-Sostenibles-Kronos-Mobile)
- 🐛 [Reportar un problema](https://github.com/Marcausente/Solucions-Socials-Sostenibles-Kronos-Mobile/issues)
- 📧 Soporte: [Contactar con el administrador]

## 👥 Créditos

- **Desarrollo Mobile:** Marc Fernández Messa
- **Aplicación Desktop Base:** Brian Bautista
- **Organización:** Solucions Socials Sostenibles

---

**Fecha de lanzamiento:** 26 de noviembre de 2025

## 🎊 ¡Gracias por usar SSS Kronos Mobile!

Si encuentras algún problema o tienes sugerencias, por favor abre un issue en el repositorio de GitHub.

