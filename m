From: "K.R. Foley" <kr@cybsft.com>
Subject: Re: The best queue for RT_PREEMPT
Date: Fri, 04 Apr 2008 15:40:11 -0500
Message-ID: <47F6922B.5080504@cybsft.com>
References: <20080404184941.GA21013@alumnos.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: =?UTF-8?B?TWF1cmljaW8g77+9?= <maray@inf.utfsm.cl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay00.pair.com ([209.68.5.9]:3066 "HELO relay00.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751167AbYDDUqw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Apr 2008 16:46:52 -0400
In-Reply-To: <20080404184941.GA21013@alumnos.inf.utfsm.cl>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Mauricio =EF=BF=BD wrote:
> Hi again,
>=20
> I have some experience working on RTAI, and I am trying to do
> something similar to a RT_FIFO. Which is the best method to have=20
> a FIFO queue between a real-time process and a non real-time process.
> Maybe a pipe is enough, or msgget, or directly have a shared memory s=
pace,
> etc... Any comment will be very welcome!
>=20
> Thanks!
>=20

Why not use a FIFO implemented as a circular buffer in shared memory?

--=20
    kr
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
