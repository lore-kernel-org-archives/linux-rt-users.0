From: "Remy Bohmer" <linux@bohmer.net>
Subject: Re: The best queue for RT_PREEMPT
Date: Fri, 4 Apr 2008 21:08:56 +0200
Message-ID: <3efb10970804041208l26b9d705qa9b7cc93a45bc6c1@mail.gmail.com>
References: <20080404184941.GA21013@alumnos.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: "=?ISO-8859-1?Q?Mauricio_A._Araya_L=F3pez?=" <maray@inf.utfsm.cl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.185]:10454 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbYDDTJE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Apr 2008 15:09:04 -0400
Received: by ti-out-0910.google.com with SMTP id 28so171700tif.23
        for <linux-rt-users@vger.kernel.org>; Fri, 04 Apr 2008 12:08:58 -0700 (PDT)
In-Reply-To: <20080404184941.GA21013@alumnos.inf.utfsm.cl>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I used a plain socket on localhost.
This works properly in our application, with little overhead, and does
not generate page-faults during RT-showtime.

Remy

2008/4/4, Mauricio A. Araya L=F3pez <maray@inf.utfsm.cl>:
> Hi again,
>
>  I have some experience working on RTAI, and I am trying to do
>  something similar to a RT_FIFO. Which is the best method to have
>  a FIFO queue between a real-time process and a non real-time process=
=2E
>  Maybe a pipe is enough, or msgget, or directly have a shared memory =
space,
>  etc... Any comment will be very welcome!
>
>  Thanks!
>
>  --
>  Mauricio Araya L.
>  ACS-UTFSM Team Leader, cel: 0-81564903
>  Est. Magister en Ciencias de la Informatica UTFSM, Valparaiso, Chile
>  counter.li.org: #249395, http://www.inf.utfsm.cl/~maray
>
> --
>  To unsubscribe from this list: send the line "unsubscribe linux-rt-u=
sers" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
