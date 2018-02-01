From: Mirza Krak <mirza.krak-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: High CPU load when using USB Bluetooth on 4.14.15-rt13 kernel
Date: Thu, 1 Feb 2018 10:58:28 +0100
Message-ID: <CALw8SCWyD8-AVtqKvPZeNQuyLfvvdLe7ZtRWuh9KH09WNDDHuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org, linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

Hi.

As I mentioned in the subject I am running a 4.14.15-rt13 kernel. The
hardware is a RK3288 SoC and this combination is producing a heavy CPU
load when an USB Bluetooth controller is simply powered on without the
need of connecting to any device.

I am running bluez5 (5.46).

This is what it looks like:

    92     2 root     RW       0   0%  20% [irq/45-dwc2_hso]
    91     2 root     RW       0   0%  11% [irq/45-ff540000]

Above is the USB interrupts of the controller where the USB bluetooth
device is connected and it is simply power on without doing anything.

Turning the controller off:

    [bluetooth]# power off
    Changing power off succeeded
    [CHG] Controller 00:15:83:EA:73:23 Powered: no
    [CHG] Controller 00:15:83:EA:73:23 Discovering: no
    [CHG] Controller 00:15:83:EA:73:23 Class: 0x000000

And the CPU load is down to minimal:

   92     2 root     SW       0   0%   2% [irq/45-dwc2_hso]
   91     2 root     SW       0   0%   2% [irq/45-ff540000]

I have tried two different USB Bluetooth devices:

    Bus 001 Device 003: ID 0a12:0001 Cambridge Silicon Radio, Ltd
Bluetooth Dongle (HCI mode)

    Bus 001 Device 005: ID 0a5c:4500 Broadcom Corp. BCM2046B1 USB 2.0
Hub (part of BCM2046 Bluetooth)

With the same result. I have also tried running a WLAN USB device and
this does not produce any high CPU load. So fairly isolated to USB
Bluetooth.

I have tried running a 4.14.15 vanilla kernel, and this does not have
this problem which means that it is the following combo

    RT + USB Bluetooth

That seem to the problem.

Before I start digging deep in to the stacks I wanted to post my
problem to the community to see if someone is having a similar problem
on a different hardware or if you have any pointers on how to further
debug this.

--=20
Med V=C3=A4nliga H=C3=A4lsningar / Best Regards

Mirza Krak
