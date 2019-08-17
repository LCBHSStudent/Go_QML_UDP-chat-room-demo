#include <QtQml>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "backend.h"
#include "KeyFilter.h"

int main(int argc, char *argv[]){
    
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    
    QGuiApplication app(argc, argv);
    
    Backend backend;
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("backend", &backend);
    engine.rootContext()->setContextProperty("keyFilter", KeyFilter::GetInstance());
    backend.init();
    
    app.setOrganizationName("van"); //1
    app.setOrganizationDomain("van.com"); //2
    app.setApplicationName("homospace"); //3
    
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);
    
    QObject *object = engine.rootObjects().first();
    //添加过滤器
    KeyFilter::GetInstance()->SetFilter(object);
    
    return app.exec();
}
