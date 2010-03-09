From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 2/2] add-smp-option-to-svsematest.patch
Date: Tue, 9 Mar 2010 19:15:32 +0100
Message-ID: <520f0cf11003091015i4c474939i8086cdd2bf98a438@mail.gmail.com>
References: <20100307204800.456744470@osadl.org>
	 <20100307204909.626988443@osadl.org> <4B968F2B.4070708@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carsten Emde <C.Emde@osadl.org>,
	RT-users <linux-rt-users@vger.kernel.org>
To: David Sommerseth <davids@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:41547 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780Ab0CISPe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Mar 2010 13:15:34 -0500
Received: by ewy8 with SMTP id 8so888921ewy.28
        for <linux-rt-users@vger.kernel.org>; Tue, 09 Mar 2010 10:15:33 -0800 (PST)
In-Reply-To: <4B968F2B.4070708@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Mar 9, 2010 at 7:10 PM, David Sommerseth <davids@redhat.com> wr=
ote:
> On 07/03/10 21:48, Carsten Emde wrote:
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (priority > 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (priority > 1 && !sameprio)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 priority--;
>
> Unless I'm missing something really obvious, shouldn't this one state=
:
>
> =A0 =A0 =A0 =A0if (priority > 0 && !sameprio)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0priority--;
>
> Or else 1 will be the lowest priority. =A0It's a similar situation in
> "[PATCH 1/2] add-smp-option-to-ptsematest.patch" as well.
>
>
> kind regards,
>
> David Sommerseth

Carsten is the owner of this code, he may very will have intended that
1 be the lowest priority, so I didn't want to second guess him.

Carsten, is it useful to have SCHED_OTHER for this test?

Thanks
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
