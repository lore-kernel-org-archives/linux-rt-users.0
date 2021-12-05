Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5DEC433EF
	for <linux-rt-users@archiver.kernel.org>; Sun,  5 Dec 2021 12:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbhLEMxA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 5 Dec 2021 07:53:00 -0500
Received: from ciao.gmane.io ([116.202.254.214]:60274 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233720AbhLEMxA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 5 Dec 2021 07:53:00 -0500
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glru-linux-rt-users@m.gmane-mx.org>)
        id 1mtqxQ-0006ws-9P
        for linux-rt-users@vger.kernel.org; Sun, 05 Dec 2021 13:49:32 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-rt-users@vger.kernel.org
From:   "S. Baerwolf" <stephan@matrixstorm.com>
Subject: Re: [ANNOUNCE] 5.10.83-rt58
Date:   Sun, 5 Dec 2021 12:49:27 +0000
Message-ID: <06a8466c-9962-4caf-51c2-1cc79c1205e6@matrixstorm.com>
References: <YalDQe/lyXqAxB0K@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YalDQe/lyXqAxB0K@uudg.org>
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Luis

Thanks for releasing rt58 on linux-5.10.

I assume you signed the
"https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/patch-5.10.83-rt58.patch.sign" 
?

Where can I get your RSA publickey 
"9354064999728D31D464D140F394A423F8E67C26" for verification?

BR Stephan


On 02.12.21 22:05, Luis Claudio R. Goncalves wrote:
> Hello RT Folks!
> 
> I'm pleased to announce the 5.10.83-rt58 stable release.
> 
> This release is just an update to the new stable 5.10.83
> version and no RT specific changes have been made.
> 
> You can get this release via the git tree at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
> 
>    branch: v5.10-rt
>    Head SHA1: 63bd813e523a6e08bb4bb04b71903d252cbcae80
> 
> Or to build 5.10.83-rt58 directly, the following patches should be applied:
> 
>    https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz
> 
>    https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.83.xz
> 
>    https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/patch-5.10.83-rt58.patch.xz
> 
> Enjoy!
> Luis
> 
> 


