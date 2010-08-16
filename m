From: Reagan Thomas <thomasraz@gmail.com>
Subject: Re: patch for NVIDIA on -rt
Date: Mon, 16 Aug 2010 16:26:41 -0500
Message-ID: <4C69AD11.7050700@gmail.com>
References: <201008162129.04308.jbh@alchemy.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Joakim Hernberg <jbh@alchemy.lu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55433 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755313Ab0HPV0W (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Aug 2010 17:26:22 -0400
Received: by gxk23 with SMTP id 23so2077287gxk.19
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Aug 2010 14:26:21 -0700 (PDT)
In-Reply-To: <201008162129.04308.jbh@alchemy.lu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  On 8/16/2010 2:29 PM, Joakim Hernberg wrote:
> For those that might need it.
>
> > From bff65cf087bae512ae9f485f4556e89d304f99a9 Mon Sep 17 00:00:00 2001
> From: Joakim B Hernberg<jbh@alchemy.lu>
> Date: Sun, 8 Aug 2010 12:39:34 +0200
> Subject: [PATCH] Patch nvidia proprietary video driver 256.44 for rt patched
> kernel 2.6.33.7-rt29
>
> ---
>   kernel/nv-linux.h |   20 ++++++++++----------
That patch works for me here.  Thank you.

I had to do a little web searching to find out how to use this patch 
and, though I'm probably the only one on this list who was ignorant of 
this procedure, I'll share it here just in case it's useful:

1. Extract the NVidia source:

      ./NVIDIA-Linux-x86-256.44.run -x

2. Apply the patch:

    cd [path]/NVIDIA-Linux-x86-256.44/kernel
    patch < [PathToPatchFile]/[PatchFilename]
    cd ..

3. Build the driver:

     ./nvidia-installer -K --kernel-name=2.6.33.7-rt29


