From: Stanislav Meduna <stano@meduna.org>
Subject: Re: e1000e 82574L transmit latency?
Date: Tue, 28 May 2013 16:05:33 +0200
Message-ID: <51A4B9AD.3060209@meduna.org>
References: <51A4A6F7.5090909@meduna.org> <20130528150135.41a6d6fb@sth491dt.servo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: =?UTF-8?B?TmVib2rFoWEgxIZvc2nEhw==?= <nebojsa@asnn.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:45055 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759087Ab3E1OFn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 28 May 2013 10:05:43 -0400
In-Reply-To: <20130528150135.41a6d6fb@sth491dt.servo.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 28.05.2013 15:01, Neboj=C5=A1a =C4=86osi=C4=87 wrote:

> Check
> http://article.gmane.org/gmane.linux.rt.user/10163 for details

Anyway, could you publish the patch? What do you mean
by "effectively disabling queuing" - that the sending threads
will wait until the packet is out or that to-be-queued
packets are thrown away?

Thanks
--=20
                                    Stano

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
