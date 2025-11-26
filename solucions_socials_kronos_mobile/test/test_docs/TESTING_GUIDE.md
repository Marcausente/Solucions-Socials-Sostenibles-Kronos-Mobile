# 🧪 Guía Completa de Testing - SSS Kronos Mobile

Esta guía te ayudará a verificar que toda la aplicación funciona correctamente mediante tests automatizados y manuales.

## 📑 Índice

- [Tests Automatizados](#-tests-automatizados)
- [Tests Manuales](#-tests-manuales)
- [Checklist de Verificación](#-checklist-de-verificación)
- [Solución de Problemas](#-solución-de-problemas)

---

## 🤖 Tests Automatizados

### 📋 Tests Disponibles

Hemos creado una suite completa de tests unitarios:

```
test/
├── config/
│   └── config_test.dart           # Tests de configuración
├── utils/
│   ├── validators_test.dart        # Tests de validadores
│   ├── date_formatter_test.dart    # Tests de formateo de fechas
│   └── roles_test.dart             # Tests de utilidades de roles
└── widget_test.dart                # Test básico de widgets
```

### 🚀 Cómo Ejecutar los Tests

#### **1. Ejecutar TODOS los tests**

```bash
cd solucions_socials_kronos_mobile
flutter test
```

Esto ejecutará todos los tests y te mostrará un resumen:

```
✓ Tests passed: XX
✗ Tests failed: 0
```

#### **2. Ejecutar tests específicos**

```bash
# Solo tests de validadores
flutter test test/utils/validators_test.dart

# Solo tests de roles
flutter test test/utils/roles_test.dart

# Solo tests de configuración
flutter test test/config/config_test.dart
```

#### **3. Ejecutar tests con más detalles**

```bash
# Ver cada test individualmente
flutter test --reporter expanded

# Ver cobertura de código
flutter test --coverage
```

#### **4. Ejecutar tests en modo watch (se reejecutarán automáticamente)**

```bash
flutter test --watch
```

### 📊 Interpretando los Resultados

#### ✅ **Tests Exitosos**
```
00:01 +32: All tests passed!
```
- Todos los tests pasaron correctamente
- La aplicación está lista para usar

#### ❌ **Tests Fallidos**
```
00:01 +28 -1: test/utils/validators_test.dart: devuelve error cuando el email es null [E]
  Expected: 'Email inválido'
    Actual: null
```
- Un test falló
- Revisa el código para corregir el problema
- Vuelve a ejecutar los tests

### 📈 Cobertura de Tests

Para ver qué porcentaje del código está cubierto por tests:

```bash
# Generar reporte de cobertura
flutter test --coverage

# Ver reporte (requiere lcov instalado)
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

---

## 🖐️ Tests Manuales

Estos tests debes realizarlos manualmente en la APK instalada en un dispositivo Android.

### 📱 Preparación

1. **Instala la APK** en un dispositivo Android real (recomendado) o emulador
2. **Asegúrate de tener conexión a internet**
3. **Ten a mano credenciales de prueba** para diferentes roles:
   - Usuario Admin
   - Usuario Gestión
   - Usuario Jefe
   - Usuario Normal

---

### 🔐 1. Tests de Autenticación

#### ✅ **Test 1.1: Login Exitoso**

**Pasos:**
1. Abre la app (primera vez)
2. Verás la pantalla de Login
3. Ingresa credenciales válidas:
   - Email: `[tu-email-test]`
   - Contraseña: `[tu-contraseña]`
4. Pulsa "Iniciar Sesión"

**Resultado Esperado:**
- ✅ Se muestra un loading spinner
- ✅ Redirige a Onboarding (primera vez) o a la app principal
- ✅ No muestra errores

#### ✅ **Test 1.2: Login con Credenciales Incorrectas**

**Pasos:**
1. Cierra sesión (si estás logueado)
2. Intenta login con credenciales incorrectas:
   - Email: `test@error.com`
   - Contraseña: `incorrecta123`
3. Pulsa "Iniciar Sesión"

**Resultado Esperado:**
- ❌ Muestra error: "Credenciales inválidas" (o similar)
- ❌ No redirige
- ✅ Los campos quedan editables

#### ✅ **Test 1.3: Login con Campos Vacíos**

**Pasos:**
1. Deja los campos de email y contraseña vacíos
2. Intenta pulsar "Iniciar Sesión"

**Resultado Esperado:**
- ❌ Muestra validación: "Campo obligatorio"
- ❌ No permite submit
- ✅ Resalta los campos con error

#### ✅ **Test 1.4: Persistencia de Sesión**

**Pasos:**
1. Inicia sesión correctamente
2. **Cierra la app completamente** (swipe up + cerrar)
3. Vuelve a abrir la app

**Resultado Esperado:**
- ✅ Se mantiene logueado
- ✅ No pide credenciales de nuevo
- ✅ Va directamente a la pantalla principal

---

### 🎓 2. Tests de Onboarding

#### ✅ **Test 2.1: Tutorial Completo**

**Pasos:**
1. Login por primera vez con usuario nuevo
2. Verás el tutorial de 4 pasos
3. Lee cada pantalla
4. Pulsa "Siguiente" en cada una
5. En la última pantalla, pulsa "Empezar"

**Resultado Esperado:**
- ✅ Muestra 4 pantallas de tutorial
- ✅ Navegación fluida entre pantallas
- ✅ Al finalizar, guarda `onboarding_completed` en BD
- ✅ Redirige a la app principal
- ✅ No vuelve a mostrar el tutorial

#### ✅ **Test 2.2: Saltar Tutorial**

**Pasos:**
1. Login por primera vez
2. En cualquier pantalla del tutorial
3. Pulsa "Saltar"

**Resultado Esperado:**
- ✅ Salta directamente a la app principal
- ✅ Guarda que el onboarding está completado
- ✅ No vuelve a aparecer el tutorial

---

### 📋 3. Tests de Hoja de Ruta

#### ✅ **Test 3.1: Ver Hoja de Ruta Actual**

**Pasos:**
1. En la pantalla principal
2. Verás la hoja de ruta más reciente

**Resultado Esperado:**
- ✅ Muestra información de la hoja de ruta:
  - Título / Nombre del evento
  - Fecha
  - Ubicación (si hay)
- ✅ Se carga sin errores
- ✅ Datos sincronizados con Desktop

#### ✅ **Test 3.2: Agregar Nota (Solo Admin/Jefe)**

**Pasos:**
1. Login como Admin o Jefe
2. En la sección "Notas Importantes"
3. Pulsa el botón "+" para agregar nota
4. Escribe una nota: "Nota de prueba"
5. Guarda

**Resultado Esperado:**
- ✅ Muestra formulario para agregar nota
- ✅ Guarda correctamente en la BD
- ✅ La nota aparece en la lista
- ✅ Sincroniza con Desktop inmediatamente

#### ✅ **Test 3.3: No Puede Agregar Nota (Usuario Normal)**

**Pasos:**
1. Login como usuario normal (rol: user)
2. En la sección "Notas Importantes"
3. Verifica que NO hay botón "+"

**Resultado Esperado:**
- ❌ No muestra botón para agregar notas
- ✅ Puede ver las notas existentes
- ✅ Mensaje: "Solo administradores y jefes pueden agregar notas"

#### ✅ **Test 3.4: Ver y Editar Horarios**

**Pasos:**
1. Ve a la sección "Horarios"
2. Verás horarios de:
   - Montaje
   - Welcome
   - Desayuno
   - Comida
   - Recogida

**Resultado Esperado:**
- ✅ Muestra todos los horarios
- ✅ Formato correcto (HH:mm)
- ✅ Permite editar (según permisos)

#### ✅ **Test 3.5: Checklist - Marcar Item**

**Pasos:**
1. Ve a la sección "Checklist de Servicio"
2. Elige un item que esté pendiente
3. Marca el checkbox
4. Asigna un responsable (si aplica)

**Resultado Esperado:**
- ✅ El checkbox se marca
- ✅ Guarda en BD inmediatamente
- ✅ Sincroniza con Desktop
- ✅ Mantiene el estado al recargar

#### ✅ **Test 3.6: Checklist - Ver Categorías**

**Pasos:**
1. En el Checklist, verifica que existen las categorías:
   - General (con sub-secciones: Pre-Evento, Durante, Post-Evento)
   - Equipamiento
   - Menús
   - Bebidas

**Resultado Esperado:**
- ✅ Todas las categorías visibles
- ✅ Items organizados correctamente
- ✅ Expandir/colapsar funciona

#### ✅ **Test 3.7: Ver Material Necesario**

**Pasos:**
1. Ve a la sección "Equipamiento y Material"
2. Verás lista de material necesario

**Resultado Esperado:**
- ✅ Lista de materiales visible
- ✅ Sin checkboxes (solo lectura)
- ✅ Tipografía legible y grande

#### ✅ **Test 3.8: Ver Menús**

**Pasos:**
1. Ve a la sección "Menús"
2. Verás secciones:
   - Welcome
   - Pausa Café
   - Comida
   - Refrescos

**Resultado Esperado:**
- ✅ Menús organizados por sección
- ✅ Datos vienen de la BD (no parsing local)
- ✅ Formato correcto

#### ✅ **Test 3.9: Ver Bebidas**

**Pasos:**
1. Ve a la sección "Bebidas"
2. Verás lista de bebidas disponibles

**Resultado Esperado:**
- ✅ Lista de bebidas visible
- ✅ Datos correctos de BD

#### ✅ **Test 3.10: Confirmar con Firma Digital**

**Pasos:**
1. Scroll hasta el final de la hoja de ruta
2. Busca "Confirmar lista y material"
3. Pulsa "Firmar"
4. Dibuja una firma en el canvas
5. Ingresa tu nombre
6. Confirma

**Resultado Esperado:**
- ✅ Se abre modal con canvas de firma
- ✅ Permite dibujar con el dedo/stylus
- ✅ Pide nombre del responsable
- ✅ Guarda firma_info y firma_responsable en BD
- ✅ Muestra badge "Verificado por [nombre]"
- ✅ **BLOQUEA todas las ediciones** en esta hoja

#### ✅ **Test 3.11: Hoja Bloqueada Después de Firma**

**Pasos:**
1. Después de confirmar una hoja (Test 3.10)
2. Intenta editar algo (nota, checklist, etc.)

**Resultado Esperado:**
- ❌ No permite editar nada
- ✅ Muestra mensaje: "Esta hoja ha sido verificada"
- ✅ Badge visible: "Verificado por [nombre]"
- ✅ Botones de edición deshabilitados

---

### 📚 4. Tests de Histórico

#### ✅ **Test 4.1: Ver Histórico de Hojas**

**Pasos:**
1. En la pantalla principal
2. Pulsa el botón "Histórico" (icono de reloj o similar)
3. Verás lista de hojas de ruta pasadas

**Resultado Esperado:**
- ✅ Muestra todas las hojas EXCEPTO la más reciente
- ✅ Ordenadas por fecha (más reciente primero)
- ✅ Cada item muestra:
  - Nombre del evento
  - Fecha
  - Estado de verificación

#### ✅ **Test 4.2: Ver Detalle de Hoja Histórica**

**Pasos:**
1. En el histórico
2. Pulsa en una hoja de ruta pasada
3. Verás todos los detalles

**Resultado Esperado:**
- ✅ Muestra todos los datos (notas, checklist, menús, etc.)
- ✅ **Solo lectura** - no permite editar
- ✅ Muestra firma si fue confirmada
- ✅ Botón "Atrás" en AppBar funciona

#### ✅ **Test 4.3: Histórico Vacío**

**Pasos:**
1. Con una cuenta nueva que solo tenga 1 hoja de ruta
2. Entra al histórico

**Resultado Esperado:**
- ✅ Muestra mensaje elegante: "No hay hojas de ruta anteriores"
- ✅ No muestra errores
- ✅ Diseño consistente

---

### ⚙️ 5. Tests de Ajustes

#### ✅ **Test 5.1: Verificar Conexión Supabase**

**Pasos:**
1. Ve a "⚙️ Ajustes"
2. Busca la tarjeta "Estado de Conexiones"
3. Verifica el estado de Supabase

**Resultado Esperado:**
- ✅ Estado: "✅ Conectado" (con internet)
- ❌ Estado: "❌ Sin conexión" (sin internet)
- ✅ Muestra URL del servidor

#### ✅ **Test 5.2: Verificar Actualizaciones**

**Pasos:**
1. En Ajustes
2. Busca "Verificar actualización"
3. Pulsa "Verificar"

**Resultado Esperado:**
- ✅ Muestra versión actual: "1.0.0"
- ✅ Consulta GitHub API
- ✅ Muestra resultado:
  - "Estás al día (1.0.0)" - si es la última
  - "Nueva versión disponible: v1.X.X" - si hay actualización
- ✅ Botón "Abrir GitHub" funciona

#### ✅ **Test 5.3: Cambiar a Modo Oscuro**

**Pasos:**
1. En Ajustes
2. Activa el switch "Modo Oscuro"

**Resultado Esperado:**
- ✅ La app cambia inmediatamente a tema oscuro
- ✅ Todos los colores se adaptan correctamente
- ✅ Legible en todas las pantallas
- ✅ AppBar con degradado correcto
- ✅ Se mantiene al cerrar y reabrir la app

#### ✅ **Test 5.4: Cambiar a Modo Claro**

**Pasos:**
1. Desactiva el switch "Modo Oscuro"

**Resultado Esperado:**
- ✅ Vuelve al tema claro
- ✅ Colores correctos
- ✅ Se mantiene la preferencia

---

### 👤 6. Tests de Perfil de Usuario

#### ✅ **Test 6.1: Ver Perfil**

**Pasos:**
1. Ve a la pantalla de "Usuario" o "Perfil"
2. Verás tu información

**Resultado Esperado:**
- ✅ Muestra:
  - Nombre de usuario
  - Email
  - Rol (Admin, Gestión, Jefe, Usuario)
- ✅ Datos correctos de Supabase
- ✅ Tema oscuro funciona correctamente

#### ✅ **Test 6.2: Cerrar Sesión**

**Pasos:**
1. En el perfil
2. Pulsa "Cerrar Sesión"
3. Confirma

**Resultado Esperado:**
- ✅ Cierra sesión en Supabase
- ✅ Redirige a pantalla de Login
- ✅ Al reabrir la app, pide credenciales

---

### 🔄 7. Tests de Sincronización

#### ✅ **Test 7.1: Sincronización en Tiempo Real con Desktop**

**Pasos:**
1. Abre la app móvil Y la app Desktop simultáneamente
2. En Desktop, crea una nueva nota
3. Observa la app móvil

**Resultado Esperado:**
- ✅ La nota aparece automáticamente en móvil (en 1-2 segundos)
- ✅ Sin necesidad de refrescar manualmente
- ✅ Datos idénticos en ambas apps

#### ✅ **Test 7.2: Sincronización Bidireccional**

**Pasos:**
1. En la app móvil, marca un checkbox del checklist
2. Observa Desktop

**Resultado Esperado:**
- ✅ El checkbox se marca en Desktop automáticamente
- ✅ Sincronización inmediata
- ✅ No hay conflictos

---

### 🌐 8. Tests de Conectividad

#### ✅ **Test 8.1: Sin Internet al Iniciar**

**Pasos:**
1. **Desactiva WiFi y datos móviles**
2. Cierra la app
3. Abre la app

**Resultado Esperado:**
- ❌ Muestra error: "Sin conexión a internet"
- ✅ No crashea la app
- ✅ Permite reintentar

#### ✅ **Test 8.2: Pérdida de Internet Durante Uso**

**Pasos:**
1. Usa la app normalmente
2. Durante el uso, **desactiva internet**
3. Intenta hacer una acción (ej: marcar checklist)

**Resultado Esperado:**
- ❌ Muestra error: "No se pudo guardar, sin conexión"
- ✅ No crashea
- ✅ Al reconectar, sincroniza automáticamente

#### ✅ **Test 8.3: Reconexión Automática**

**Pasos:**
1. Sin internet, intenta usar la app
2. **Reactiva internet**
3. Espera unos segundos

**Resultado Esperado:**
- ✅ Se reconecta automáticamente
- ✅ Carga los datos
- ✅ Sincroniza cambios pendientes (si los hay)

---

### 🎨 9. Tests de UI/UX

#### ✅ **Test 9.1: Responsive en Diferentes Tamaños**

**Pasos:**
1. Prueba la app en:
   - Móvil pequeño (5")
   - Móvil grande (6.5")
   - Tablet (si disponible)

**Resultado Esperado:**
- ✅ UI se adapta correctamente
- ✅ Texto legible en todos los tamaños
- ✅ Botones accesibles
- ✅ No hay overflow de contenido

#### ✅ **Test 9.2: Orientación Horizontal**

**Pasos:**
1. Rota el dispositivo a modo horizontal
2. Navega por la app

**Resultado Esperado:**
- ✅ UI se adapta a landscape
- ✅ Contenido visible y usable
- ✅ No hay elementos cortados

#### ✅ **Test 9.3: Scrolling Suave**

**Pasos:**
1. En una hoja de ruta larga
2. Haz scroll desde arriba hasta abajo
3. Usa scroll rápido y lento

**Resultado Esperado:**
- ✅ Scroll fluido sin lag
- ✅ No hay saltos
- ✅ Contenido se carga correctamente

---

### 🔒 10. Tests de Permisos por Rol

#### ✅ **Test 10.1: Permisos de Admin**

**Login como Admin:**
- ✅ Puede agregar/eliminar notas
- ✅ Puede editar todos los campos
- ✅ Puede confirmar hojas de ruta
- ✅ Puede ver histórico
- ✅ Acceso completo a todas las funciones

#### ✅ **Test 10.2: Permisos de Gestión**

**Login como Gestión:**
- ✅ Puede agregar/eliminar notas
- ✅ Puede editar checklist
- ✅ Puede confirmar hojas de ruta
- ✅ Puede ver histórico

#### ✅ **Test 10.3: Permisos de Jefe**

**Login como Jefe:**
- ✅ Puede agregar/eliminar notas
- ✅ Puede editar checklist
- ✅ Puede confirmar hojas de ruta
- ✅ Puede ver histórico

#### ✅ **Test 10.4: Permisos de Usuario Normal**

**Login como Usuario:**
- ❌ NO puede agregar/eliminar notas (solo ver)
- ✅ Puede ver checklist
- ✅ Puede marcar items del checklist
- ❌ NO puede confirmar hojas de ruta
- ✅ Puede ver histórico (solo lectura)

---

## ✅ Checklist de Verificación Rápida

Usa este checklist antes de liberar una nueva versión:

### 🔐 Autenticación
- [ ] Login exitoso funciona
- [ ] Login con credenciales incorrectas muestra error
- [ ] Sesión persiste al cerrar y abrir app

### 📋 Hoja de Ruta
- [ ] Se carga correctamente la hoja actual
- [ ] Checklist funciona (marcar/desmarcar)
- [ ] Firma digital funciona y bloquea ediciones
- [ ] Histórico muestra hojas pasadas

### ⚙️ Funcionalidades
- [ ] Modo oscuro/claro funciona
- [ ] Detector de actualizaciones funciona
- [ ] Sincronización con Desktop funciona
- [ ] Permisos por rol funcionan correctamente

### 🌐 Conectividad
- [ ] Funciona con internet
- [ ] Maneja correctamente falta de internet
- [ ] Reconexión automática funciona

### 🎨 UI/UX
- [ ] UI responsive en diferentes tamaños
- [ ] Scrolling fluido
- [ ] No hay crashes ni errores visuales

---

## 🐛 Solución de Problemas

### ❌ **Tests Fallan**

**Problema:** Al ejecutar `flutter test` algunos tests fallan.

**Soluciones:**
1. Asegúrate de tener todas las dependencias:
   ```bash
   flutter pub get
   ```

2. Limpia y recompila:
   ```bash
   flutter clean
   flutter pub get
   flutter test
   ```

3. Verifica que el código no haya cambiado desde que se crearon los tests

### ❌ **No Puede Conectar a Supabase**

**Problema:** La app no conecta a la base de datos.

**Soluciones:**
1. Verifica que tienes internet
2. Verifica que Supabase está activo:
   ```bash
   curl https://zalnsacawwekmibhoiba.supabase.co
   ```
3. Verifica que la APK fue compilada con los permisos correctos (INTERNET)

### ❌ **Detector de Actualizaciones No Funciona**

**Problema:** Al verificar actualizaciones no encuentra releases.

**Soluciones:**
1. Verifica que publicaste la release en GitHub
2. Verifica que el tag es correcto (v1.0.0)
3. Verifica que la APK está adjunta a la release

---

## 📝 Reportar Bugs

Si encuentras un bug durante el testing:

1. **Anota:**
   - Qué estabas haciendo
   - Qué esperabas que pasara
   - Qué pasó realmente
   - Pasos para reproducir

2. **Captura:**
   - Screenshots
   - Logs (si es posible): `adb logcat`

3. **Reporta:**
   - Crea un issue en GitHub
   - Incluye toda la información del punto 1 y 2

---

## 🎯 Conclusión

Esta guía cubre todos los aspectos importantes del testing. Asegúrate de ejecutar:

1. ✅ **Tests automatizados** antes de cada release
2. ✅ **Tests manuales críticos** antes de publicar
3. ✅ **Checklist de verificación** antes de marcar como "lista para producción"

**¿Todo verde? 🎉 ¡La app está lista para ser usada!**

