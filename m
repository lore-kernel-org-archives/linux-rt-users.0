From: Dragan Noveski <perodog@gmx.net>
Subject: some config questions
Date: Fri, 15 Jun 2007 14:12:28 +0200
Message-ID: <4672822C.2000808@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:43138 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755818AbXFOMNF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Jun 2007 08:13:05 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

hi to the list!
i am new here ( i subscribed yesterday ) and i am really happy that i 
have found this list finally, because i hope that i can get some answers 
here, which i do not get in the LAU.

first about my setup: using ibm-thinkpad-R50e with the rme-multiface on 
a debian-testing, using selfcompiled jack/alsa/music appi's.
i begun with the 2.6.12-mm kernel from demudi, but with 2.6.13 i am 
compiling the kernel my self (got my first .config as a present from my 
neighbors! ).
another important information about my setup is that i am accessing 
internet vie an ad-hoc network using the usb-atmel driver (at76_usb) 
from the git sources.

in the moment i am writing from 2.6.21.3-rt9, and just yesterday i 
managed to implement the high-resolution-timer - the joke was really to 
disable all the acpi stuff.

so toggling with menuconfig for about a year 'n a half now, there are 
still come options, which i am not sure if i am answering correctly, and 
googling for them, i only find some pages with no answer for me ( too 
complicated kernel-hacker-language).

that's why i ll put the questions here in the hope that someone of you 
will have time/passions to answer some of the neewbe questions!?
i ll try to structure the questions so, that it might be easy to answer 
with just short instructions, please apologize if i am wrong.

so, here it goes:


-block layer
      -IO shedulers
            -anticipatory
            -deadline
            -cfq
                   -default-cfg(?)

i have marked all tree possibilities, the default one is cfg - please 
comment!

..........................

-processor types and features
           -local apic support on uniprocessor
           -IO apic support on uniprocessors

is it recommended to activate or not?
not sure if this is the something to do that i managed  to change the 
irq's via bios  for my  yenta-socket (which is now almost alone at the 
irq10)?

.........................

-networking
         -networking options
                 -QoS and/or fair queueing
                            -timer interrupt (choosed in the moment)
                            -gettimeofday
                            -CPU cycle counter

any idea of which option could be recommanded?

..........................

-device drivers
          -RTC
               -sysfs
               -proc
               -dev   -which one to choose?

          -set system time from RTC on startup   -  do we need this?


...................

-device drivers
            -character devices
                     -generic /dev/rtc emulation

do we want this emulation to work or not?

.....................

ok, that was it - i know it is a little much and it is not 'one question 
per thread' style, but i am thinking that this way is good too and that 
i ll get some (for me) useful answers/suggestions?!


cheers,
doc
