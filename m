From: Clark Williams <clark.williams@gmail.com>
Subject: Re: add mlockall option to cyclictest, et al
Date: Sat, 10 May 2008 14:30:35 -0500
Message-ID: <4825F7DB.6000808@gmail.com>
References: <48249E2C.3010601@gmail.com> <4825F5AF.7010700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
	Luis Claudio Goncalves <lclaudio@uudg.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Robert de Vries <robert.h.de.vries@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:49249 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752717AbYEJTaj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 10 May 2008 15:30:39 -0400
Received: by py-out-1112.google.com with SMTP id u52so1962973pyb.10
        for <linux-rt-users@vger.kernel.org>; Sat, 10 May 2008 12:30:38 -0700 (PDT)
In-Reply-To: <4825F5AF.7010700@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Robert de Vries wrote:
> Clark Williams wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Thomas,
>>
>> Got a couple of requests for mlockall() in cyclictest, so I added an
>> --mlockall
>> option to cyclictest, signaltest and pi_stress.
>>   
> One small remark: it would be better to do the mlockall() by default. As
> far as I know this should be done always for real-time applications.
> I am actually surprised that it is not done already. It is also
> mentioned in the Howto build an RT-application on the RT linux wiki.
> 
>    Robert
> 
> 

I thought about that, but figured it would be better just to have the option rather
than change long-standing behavior.

It's Thomas's call though :)

Clark

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkgl99sACgkQqA4JVb61b9eV4gCgiIs5QHocKBRHyOsGlMw+F5BA
PuUAnRo5+9oeO5oMFjq55JUxaR7dBI2b
=pefi
-----END PGP SIGNATURE-----
