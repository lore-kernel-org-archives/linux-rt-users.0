From: Sbs <sbs.pub@gmail.com>
Subject: Re: Doubt: Does RT patch reduce interrupt latency?
Date: Sun, 26 Jul 2009 08:51:56 +0530
Message-ID: <4cd511390907252021m78ae5c14hb8faaef9459eed6e@mail.gmail.com>
References: <4cd511390907241111x3c6c9bbcw25230775c34ba3e@mail.gmail.com>
	 <1248462240.7533.14.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:1289 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681AbZGZDV4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 25 Jul 2009 23:21:56 -0400
Received: by rv-out-0506.google.com with SMTP id f6so683949rvb.1
        for <linux-rt-users@vger.kernel.org>; Sat, 25 Jul 2009 20:21:56 -0700 (PDT)
In-Reply-To: <1248462240.7533.14.camel@sven.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> Did you raise the priority for the 1 ms IRQ thread?

Sorry, this test was done by one of my team-mate. I should have
gathered enough information before mailing. I will check with him and
if that was not done, we will try again with raised priority. Then I
will get back to the list with more details and queries.

However, we did use the nodelay flag while requesting the IRQ. If
nodelay flag is used, does the priority still matter? Doesn't the use
of this flag make the kernel to treat this interrupt in the
traditional way? Are we really making use of any rt capability?

Btw, we are testing this on ARM platform.

Thanks,
Sbs

>
>> Thanks in advance,
>>
>> Regards,
>> Sbs
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-u=
sers" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
