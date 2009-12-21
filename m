From: John Kacur <jkacur@gmail.com>
Subject: Re: [PATCH 3/4] rt-tests: Clean-up - protect rt-utils.h
Date: Tue, 22 Dec 2009 00:41:28 +0100
Message-ID: <520f0cf10912211541s5290b08i11171c6251b3a0ca@mail.gmail.com>
References: <1261431950-28500-1-git-send-email-jkacur@redhat.com>
	 <1261431950-28500-2-git-send-email-jkacur@redhat.com>
	 <1261431950-28500-3-git-send-email-jkacur@redhat.com>
	 <1261431950-28500-4-git-send-email-jkacur@redhat.com>
	 <4B30002F.3030209@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Carsten Emde <Carsten.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:59282 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbZLUXla convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Dec 2009 18:41:30 -0500
Received: by ey-out-2122.google.com with SMTP id 25so125788eya.19
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Dec 2009 15:41:28 -0800 (PST)
In-Reply-To: <4B30002F.3030209@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Dec 22, 2009 at 12:09 AM, Carsten Emde <Carsten.Emde@osadl.org>=
 wrote:
> On 12/21/2009 10:45 PM, John Kacur wrote:
>> Clean-up: Protect rt-utils.h with #ifndef RT_UTILS_H
>> [..]
>> +#ifndef RT_UTILS.H
> Macro names should only consist of alphanumeric characters and
> underscores, i.e. 'a-z', 'A-Z', '0-9', and '_', and the first charact=
er
> should not be a digit.
>
> Signed-off-by: Carsten Emde <C.Emde@osadl.org>
>
> diff --git a/src/lib/rt-utils.h b/src/lib/rt-utils.h
> index fbdcf2b..e7a1908 100644
> --- a/src/lib/rt-utils.h
> +++ b/src/lib/rt-utils.h
> @@ -1,5 +1,5 @@
> -#ifndef RT_UTILS.H
> -#define RT_UTILS.H
> +#ifndef RT_UTILS_H
> +#define RT_UTILS_H
>
> =A0#define _STR(x) #x
> =A0#define STR(x) _STR(x)
> @@ -8,4 +8,4 @@
> =A0int check_privs(void);
> =A0char *get_debugfileprefix(void);
>
> -#endif /* RT_UTILS.H */
> +#endif /* RT_UTILS_H */
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

Thanks Carsten.

That was a good sign that I was getting tired! I think Clark already
fixed that up.

John
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
