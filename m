From: Bert Schiettecatte <bert@bertschiettecatte.com>
Subject: Fwd: changes to scheduler from mainline 4.8 to 4.10?
Date: Wed, 29 Mar 2017 08:55:33 -0700
Message-ID: <CALd3UbQo=F6YtQ-LUrw0YaX2=PdpyXh+EFueKYn4MnRtUE748Q@mail.gmail.com>
References: <CALd3UbSKV_Qzun=9Hhwe=omP5f4A3gyOi_nGNM6JA4d5ziFZ_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:34421 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbdC2Pzp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Mar 2017 11:55:45 -0400
Received: by mail-yw0-f171.google.com with SMTP id p77so13717945ywg.1
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Mar 2017 08:55:39 -0700 (PDT)
In-Reply-To: <CALd3UbSKV_Qzun=9Hhwe=omP5f4A3gyOi_nGNM6JA4d5ziFZ_g@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

I'm working on a realtime audio application running on a rk3288
platform. The application is written in the JUCE framework, and uses
ALSA for audio output. I build the application in a debian jessie
chroot since it needs a bunch of libraries compiled for armhf.

The application used to run fine on 4.8 mainline, without noticable
audio dropouts. I had to upgrade recently to 4.10 mainline to get the
audio gadget driver working, but now the application has audio
dropouts (pause in the audio output).

I have been using 44100 hz sample rate and 960 samples buffer size for
testing. I increased the buffer size to 1280 which seemed to improve
things a little, and then after googling around I changed the IO
scheduler to noop (it was set to CFQ), which further increases the
performance. I now only have occasional audio dropouts.

The application does a lot of I/O via HID and has 4 audio processing
threads for signal processing, besides other threads and callbacks for
HID I/O.

Questions:

1) Does anyone know if something has changed between kernel 4.8 and
4.10 with regard to the scheduler that might negatively impact
realtime audio or RT performance in general?
2) are there specific kernel settings I should check?
3) I am wondering if RT patches are still relevant for newer kernels
like 4.8 and 4.10?
4) I saw that the latest patches are for kernel 4.4, can they be
applied to later kernels and is that a good idea or not?

Thanks for helping!

Bert
