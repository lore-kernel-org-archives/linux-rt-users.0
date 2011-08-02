From: Oon-Ee Ng <ngoonee.talk@gmail.com>
Subject: Re: various tests for 3.0 rt3
Date: Tue, 2 Aug 2011 09:15:54 +0800
Message-ID: <CAGQ70euqsqjxgwu_ySG=pYSMWEEC_vNvoiCQ6hFe2sPFPhCTpA@mail.gmail.com>
References: <201107251738.51473.jordipujolp@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	"J. R. Okajima" <hooanon05@yahoo.co.jp>
To: Jordi Pujol <jordipujolp@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35848 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752962Ab1HBBP4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Aug 2011 21:15:56 -0400
Received: by ewy4 with SMTP id 4so3041430ewy.19
        for <linux-rt-users@vger.kernel.org>; Mon, 01 Aug 2011 18:15:54 -0700 (PDT)
In-Reply-To: <201107251738.51473.jordipujolp@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Jul 25, 2011 at 11:38 PM, Jordi Pujol <jordipujolp@gmail.com> wrote:
> Hello,
>
> Testing 3.0 rt3 with overlayfs, aufs, tuxonice, nvidia drivers,
>
> to compile the NVIDIA propietary driver, kernel has to export as non-GPL the
> following symbols,
>
> __rt_mutex_init
> migrate_enable
> migrate_disable
<snip>

Does anyone have a patch for this? Previously it was the nvidia
drivers which needed to be patched, but it seems in this case the
patch needs to be kernel-side?
