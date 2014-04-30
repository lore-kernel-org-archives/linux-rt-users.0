From: Corey Minyard <cminyard@mvista.com>
Subject: Re: Can PAX and Rt-patch co-exist ?
Date: Wed, 30 Apr 2014 18:53:46 -0500
Message-ID: <53618D0A.2050609@mvista.com>
References: <CAPFcPTL10dY0NjYUrQ-q_W81RRFReiA0jTeseC8tC8_FZViWkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Mau Z <zmau1962@gmail.com>, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:64432 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754724AbaD3Xxt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 30 Apr 2014 19:53:49 -0400
Received: by mail-oa0-f46.google.com with SMTP id i4so2133519oah.5
        for <linux-rt-users@vger.kernel.org>; Wed, 30 Apr 2014 16:53:49 -0700 (PDT)
In-Reply-To: <CAPFcPTL10dY0NjYUrQ-q_W81RRFReiA0jTeseC8tC8_FZViWkQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 04/30/2014 05:47 PM, Mau Z wrote:
> I have some more questions concerning the relation between PAX and the
> RT-Patch :
> A) Can they work together ?

It can be made to work.  We have it working together in our distribution.

> B) Do you know if it matters which patch is applied first ?

Not really.

> C) Is there any documentation about this subject ?

None that I know of.  I imagine that I'm the only person who has ever
done this.

There are some conflicts (a few are non-trivial, but not excessively
complicated, IIRC).  But it's not something insurmountable.  You do have
to have a fairly good understanding of kernel code.

-corey

>
>
> Thanks
> zmau
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

