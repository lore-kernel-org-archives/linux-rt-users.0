From: rolf.freitag@email.de
Subject: Re: Where are the branches for stable/v1.0 and unstable/devel?
Date: Sat, 27 May 2017 23:43:45 +0200
Message-ID: <trinity-363cee20-7cf0-4d43-b5d7-058ae3582716-1495921425917@3capp-webde-bs06>
References: <trinity-81b115be-c7aa-430f-a6bb-a9f8512e0222-1495478595984@3capp-webde-bap56>
 <1495483301.9833.3.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:63866 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750750AbdE0Vns (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 27 May 2017 17:43:48 -0400
In-Reply-To: <1495483301.9833.3.camel@intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Vedang, 

On Mon, 2017-05-22 at 20:43 +0200, vedang.patel@intel.com wrote:
> ...
> The following 2 branches in the above repository have been most
> recently updated and correspond to the stable and unstable branch: 
> 0e6c2ca28adbaeb668ca35210cec546f89938bfa        refs/heads/stable/devel
> /v1.0.1
> 44de1a494583c33e72335221360085f9e1faad2b        refs/heads/unstable/dev
> el/v1.1.1
> There is also a stable/v1.0 branch: 
> d48504b8e85961afab1cb0bd346624eb31527197        refs/heads/stable/v1.0
> 
> the wiki page you mentioned in your email is outdated. Please refer to 
> https://wiki.linuxfoundation.org/realtime/documentation/howto/tools/cyc[https://wiki.linuxfoundation.org/realtime/documentation/howto/tools/cyc]
> lictest for the latest info.

Ok, due to https://wiki.linuxfoundation.org/realtime/documentation/howto/tools/rt-tests
i can get the stable/v1.0 via:

# git clone git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git 
# cd rt-tests
# git checkout stable/v1.0

But when i try it with the other two versions,

git checkout stable/devel
git checkout unstable/dev

i get no checkout and an error:

error: pathspec 'stable' did not match any file(s) known to git.

Regards,

Rolf
