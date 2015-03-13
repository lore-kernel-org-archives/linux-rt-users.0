From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: btrfs and linux-rt
Date: Fri, 13 Mar 2015 12:38:32 +0100
Message-ID: <20150313113832.GE5592@linutronix.de>
References: <CAF73Y=Qfsw=Yre6d_kP7Vmn+Ln1L4viBVRPksdomdGKVzDu+6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Daniel Kasak <d.j.kasak.dk@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55826 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbbCMLid convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Mar 2015 07:38:33 -0400
Content-Disposition: inline
In-Reply-To: <CAF73Y=Qfsw=Yre6d_kP7Vmn+Ln1L4viBVRPksdomdGKVzDu+6Q@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Daniel Kasak | 2015-03-12 15:16:24 [+1100]:

>Greetings.
Hi Daniel,

>I've just re-installed Linux on my laptop, and to my horror ... linux-=
rt is
>not compatible with btrfs. I have all my partitions using btrfs now. W=
hen
>Linux boots, it hangs when mounting the root partition. I've searched
>around a little, and found others reporting the same. Are there any pl=
ans
>to sort out this incompatibility?

I remember some people complained about btrfs. I then bootet a kvm
machine with btrfs as rootfs and it worked fine=E2=80=A6 Are you using =
some
"special" btrfs features or is this just a plain install?

>Thanks :)
>
>Dan

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
