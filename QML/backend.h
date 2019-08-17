#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QUdpSocket>
#include <QHostAddress>

//using namespace std;

const int port = 8848;

class Backend : public QObject {
    Q_OBJECT
public:
    explicit Backend(QObject *parent = nullptr);
    void init();
    
    Q_INVOKABLE void send_message_test(QVariant msg);
public slots:
    
    void read_msg();
    
signals:
    void newMsg(QVariant msg);
    void welcome();
    void loginS();
    void loginF();
    void signS();
    void signF();
    void getChatMsg(QVariant id, QVariant msg, QVariant name, QVariant room);
    void clearRoom();
    void getNewRoom(QVariant id);
    void getRoomFinish();
    void getShowYearChampion(QVariant id, QVariant name, QVariant time, QVariant sygj);
    void memberAdd(QVariant roomid);
private:
    QUdpSocket* m_socket;
    
    enum {START_CODE = 1000, LOGINSMG_CODE, SIGNIN_CODE, GET_MSG_CODE, 
          GEI_INTO_ROM = 1005, QUIT_THE_ROOM, NEW_ROOM, ROOM_FINISH,
          MEMBER_IN, MEMBER_OUT, SHOWYEAR_CHAMPION};
    
    enum {LOGIN_SUCCESS = 8100, LOGIN_FAILED, SIGN_SUCCESS, SIGN_FAILED};
};

#endif // BACKEND_H
