From: Sujit K M <sjt.kar@gmail.com>
Subject: Re: mq_timedrecieve timeout accuracy
Date: Wed, 24 Mar 2010 19:15:09 +0530
Message-ID: <921ca19c1003240645s5c69fde9l464618ec7aa644af@mail.gmail.com>
References: <6d09081c1003240527r471ee34etbba11b4b7c7e92b3@mail.gmail.com>
	 <8226231.1269436934345.JavaMail.ngmail@webmail10.arcor-online.net>
	 <6d09081c1003240637w28ee6861tfcef4c7876ef3e40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "M. Koehrer" <mathias_koehrer@arcor.de>,
	linux-rt-users@vger.kernel.org, rachana.rao@in.abb.com
To: Pradyumna Sampath <pradysam@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37261 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755331Ab0CXNpK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Mar 2010 09:45:10 -0400
Received: by pva18 with SMTP id 18so409876pva.19
        for <linux-rt-users@vger.kernel.org>; Wed, 24 Mar 2010 06:45:10 -0700 (PDT)
In-Reply-To: <6d09081c1003240637w28ee6861tfcef4c7876ef3e40@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> time =3D schedule_timeout(timeout);
=46ine.

> Maybe this is why produces a timeout that is inaccurate. Shouldnt it
> be schedule_hrtimeout ?

Does the RT Patch change anything. OR is it the same.

>
> regards
> /prady
>
> --
> http://www.prady.in
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
-- Sujit K M

blog(http://kmsujit.blogspot.com/)
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
