From: rolf.freitag@email.de
Subject: Aw: Re: Where are the branches for stable/v1.0 and unstable/devel?
Date: Tue, 23 May 2017 01:14:44 +0200
Message-ID: <trinity-23e9b876-7a25-4560-995c-4cd3a4373c90-1495494884583@3capp-webde-bap62>
References: <trinity-81b115be-c7aa-430f-a6bb-a9f8512e0222-1495478595984@3capp-webde-bap56>
 <1495483301.9833.3.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:65244 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758552AbdEVXOq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 19:14:46 -0400
In-Reply-To: <1495483301.9833.3.camel@intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thanks, the "git checkout stable/v1.0" worked, but not "git checkout unstable/devel".

How do i get the delvel version?

Regards, 

Rolf 
 
-------------------------------------------------------------------------
Betreff: Re: Where are the branches for stable/v1.0 and unstable/devel?
Hi Rolf,

On Mon, 2017-05-22 at 20:43 +0200, rolf.freitag@email.de wrote:
> Hi,
>  
> due to https://rt.wiki.kernel.org/index.php/Cyclictest i tried
>  
>   git clone git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
>  
> but the README from there says that the stable/v1.0 and
> unstable/devel branch is not there.
> I tried the sources
>  
>   git://git.kernel.org/pub/scm/utils/rt-tests/unstable/devel.git
>   git://git.kernel.org/pub/scm/utils/rt-tests/unstable.git
>   ...
>  
> but without success.
>  
> Where are these branches?
The following 2 branches in the above repository have been most
recently updated and correspond to the stable and unstable branch: 
0e6c2ca28adbaeb668ca35210cec546f89938bfa        refs/heads/stable/devel
/v1.0.1
44de1a494583c33e72335221360085f9e1faad2b        refs/heads/unstable/dev
el/v1.1.1
There is also a stable/v1.0 branch: 
d48504b8e85961afab1cb0bd346624eb31527197        refs/heads/stable/v1.0

the wiki page you mentioned in your email is outdated. Please refer to 
https://wiki.linuxfoundation.org/realtime/documentation/howto/tools/cyc[https://wiki.linuxfoundation.org/realtime/documentation/howto/tools/cyc]
lictest for the latest info.

Thanks,
Vedang Patel
 
>  
> Regards,
>  
> Rolf
>  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-
> users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html[http://vger.kernel.org/majordomo-info.html]
