# 📱 SSS Kronos Mobile v1.0.1

## 🆕 Cambios Clave

- ✅ **Hoja de ruta correcta**: la app ya siempre muestra la hoja de ruta más reciente, evitando que aparezcan rutas antiguas cuando se crean múltiples registros en Supabase.
- ✏️ **Edición de rutas antiguas**: ahora puedes volver a las hojas históricas y editarlas (notas, checklist, personal) siempre que tengas permisos de rol.

## 🛠️ Detalles Técnicos

| Área | Mejora |
|------|--------|
| Carga de datos | La selección de la hoja activa toma el último registro actualizado para mantener la app sincronizada con Desktop. |
| Histórico | Se habilita la edición segura de hojas anteriores respetando el estado de firma y los permisos por rol. |

## 🧪 Testing

- `flutter test` – ✅ todos los tests pasan (70 suites).
- Verificado en **Android** (APK release) y en **iOS Simulator** (debug).

## 📦 Descarga

- **APK**: `SSS-Kronos-Mobile-v1.0.1.apk`
- **iOS**: ejecutar `flutter run` con un dispositivo o simulador configurado

## 🚀 Pasos de despliegue

1. `flutter build apk --release`
2. `flutter build ios --release` (si aplicable)
3. Crear release en GitHub con tag `v1.0.1`
4. Adjuntar la APK y pegar estas notas

---

_Fecha_: 28 de noviembre de 2025  
_Autor_: Marc Fernández Messa

