From: pavel <pavel@pavlinux.ru>
Subject: Re: Where IOSCHED ?
Date: Sat, 25 Jul 2015 14:27:43 +0300
Message-ID: <55B372AF.7080407@pavlinux.ru>
References: <55AFF784.7040900@pavlinux.ru>
 <20150723123922.GA31936@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from forward11h.cmail.yandex.net ([87.250.230.153]:59022 "EHLO
	forward11h.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751017AbbGYLcw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 25 Jul 2015 07:32:52 -0400
In-Reply-To: <20150723123922.GA31936@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

23.07.2015 15:39, Sebastian Andrzej Siewior =D0=BF=D0=B8=D1=88=D0=B5=D1=
=82:
> * Pavel Vasilyev | 2015-07-22 23:05:24 [+0300]:
>> [    0.388079] io scheduler cfq registered (default)
>> # cat /sys/block/sda/queue/scheduler
>> none
> Does the same thing happen with plain v3.18.17? Because if it does th=
en
> it is not a -RT problem.
# gzip -cd ../patch-3.18.17-rt14.patch.gz | patch -p1 -R;
#  make oldconfig; make; make install; make modules_install; reboot;
=2E..
# cat /sys/block/{sd,md}*/queue/scheduler
none
none
none
none
none
none

Ooops  o.0

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
