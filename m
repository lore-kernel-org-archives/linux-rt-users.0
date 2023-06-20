Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC9EEB64D7
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Jun 2023 15:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjFTPon (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 20 Jun 2023 11:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjFTPok (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 20 Jun 2023 11:44:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18821E65
        for <linux-rt-users@vger.kernel.org>; Tue, 20 Jun 2023 08:44:39 -0700 (PDT)
Date:   Tue, 20 Jun 2023 17:44:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687275877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gkELjc8aL94gd9Llh9LdVjUlfbv2lnjarqV7KwXX/2g=;
        b=VUl8vmjI2ikho1sYo0DimByYbRUhqT/zm/5wpCQp/p3Kf3UBa6Upk9uz/Dod/RlFw90864
        LLw61sbtg3C5QDOGk81GcuiZquKT/edh7NZyzAeqmrJSbl4JP5Zajldn5qzpjN9aV6vAM2
        vCO6utUhLF8oa65XWcE0GC5cArD8w0QugH+3rcS5Nk+8qc9b3MdNT0Ccb/W0Eo0yGTClFB
        KJeaQc0QeJucMPnMe+9OCuknw3ogQgpCuvzhPZe9IVdLV2OruQLkLK2BrRACIIl7R9zyTg
        FgV1j912l2O1wM5BmGZFzLX7QjDrTsgCIqVYl7ZNkixpzgegbWk6BlUTVNJVBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687275877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gkELjc8aL94gd9Llh9LdVjUlfbv2lnjarqV7KwXX/2g=;
        b=yPcLA2TbYtR3auX/NnO7Fs7wTBoivjhOzpZdoLHXsR1yt2y3epX5ds7VSh3hI186eJR1Y+
        BLG/YWyt+BHQP1Ag==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc:     Linux RT Users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v6.4-rc5-rt4] rt: vmd: make cfg_lock a raw spinlock
Message-ID: <20230620154434.MosrzRUh@linutronix.de>
References: <ZIJwNBZa0UUTAx5i@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZIJwNBZa0UUTAx5i@uudg.org>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-06-08 21:20:04 [-0300], Luis Claudio R. Goncalves wrote:
> Sebastian, Steven,
> 
> I don't know if this is the best solution for the problem, but surely the
> simplest one. If this patch makes sense, it could probably go upstream as
> the changes only affect RT.

Lockdep should complain, too because the locking order here is
raw_spinlock_t -> spinlock_t. 

Instead of making the lock raw, I would argue to remove the lock an safe
a few cycles. The lock is only used by vmd_pci_read() and
vmd_pci_write(). Both functions are invoked by pci_bus_read_config_*()
or pci_bus_write_config_*() and both acquire pci_lock first. Therefore
the lock does not add any benefit because vmd_pci_read() vs
vmd_pci_write() is already serialized.

If you make the patch feel free to reuse the wording above.

From a quick look,
   drivers/pci/controller/pci-tegra.c
   drivers/pci/controller/pcie-rcar-host.c

could use some care ;)

Sebastian
