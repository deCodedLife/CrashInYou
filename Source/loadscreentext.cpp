#include "loadscreentext.h"

LoadScreenText::LoadScreenText(QObject *parent)
    : QObject(parent),
      _text("Loading")
{
}

void LoadScreenText::text(QString text) {
    if ( _text == text )
        return;
    _text = text;
}

QString LoadScreenText::text() {
    return _text;
}
