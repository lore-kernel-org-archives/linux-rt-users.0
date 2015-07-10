From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Re: [PATCH 5/6] Change VERSION_STRING to VERSION
Date: Fri, 10 Jul 2015 16:42:52 +0300
Message-ID: <559FCBDC.1090005@pavlinux.ru>
References: <1436531131-9186-1-git-send-email-jkacur@redhat.com>
 <1436531131-9186-6-git-send-email-jkacur@redhat.com>
Reply-To: pavel@pavlinux.ru
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Siewior <bigeasy@linutronix.de>
To: John Kacur <jkacur@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from imp04.mtu.ru ([62.5.255.37]:47750 "EHLO imp04.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932515AbbGJNnE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Jul 2015 09:43:04 -0400
In-Reply-To: <1436531131-9186-6-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

10.07.2015 15:25, John Kacur =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> +VERSION =3D 0.92
> ...
> +	printf("cyclictest V %1.2f\n", VERSION);

Eight other versions and overflow ? ;)


--=20

                                                          Pavel.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
