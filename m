Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAA3C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 29 Mar 2022 07:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiC2HEV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 29 Mar 2022 03:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiC2HET (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 29 Mar 2022 03:04:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCDB689A2
        for <linux-rt-users@vger.kernel.org>; Tue, 29 Mar 2022 00:02:36 -0700 (PDT)
Date:   Tue, 29 Mar 2022 09:02:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648537355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jRHsfexOs7K+UYs/DePjmLhYZUW70RFq9D+Yh9OC5gg=;
        b=dEA+BTPF+WYbidrGiVmN4H+DV1LdY0uoNkfzGjLhiMZTR6W0SAFz7YIYceqwzWF9vK3pZC
        lh/ddPOlxaoO0LkoGUaicucChuFc5pl+Zuf9w+Ilwyui09B5yJ4mKilqGSfElltXFkKP04
        kHtnY3cmUjuJ/oHZdU22T/a216nxX7QQK7s1lnp9FSJFREXYuzgfzK9TA8v0JVR0ThgH+5
        87RkKM9CZE0Fd4oTNazURQ4hVeGz+ErEOPLFdJx+emL0/nKDR4qlkrAWA8TozJ2ka1AvH6
        00VjOQ7BEHtUnC0WZ8JcRmqKswqCobHIYNgtl3HLhXbFxC7OV+5+VM04li8AMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648537355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jRHsfexOs7K+UYs/DePjmLhYZUW70RFq9D+Yh9OC5gg=;
        b=A0ZqmdjmQj5SKFxJaJ3hVkeuW4LdMOxTFljQp36T3SvrpCokkMgLJg8xarCrM1YojH4/eh
        7ynp0NMbyxa/FUBQ==
From:   "bigeasy@linutronix.de" <bigeasy@linutronix.de>
To:     "Chen, Angus" <angus.chen@intel.com>
Cc:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "Chang, Junxiao" <junxiao.chang@intel.com>,
        "Ung, Teng En" <teng.en.ung@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: RT  kernel video playback issue (screen freeze)
Message-ID: <YkKvCf3wOnGaZDMw@linutronix.de>
References: <DM6PR11MB4596027F97399B46BCD7681B8F199@DM6PR11MB4596.namprd11.prod.outlook.com>
 <DM6PR11MB459605ADA58FBEAE43EDD3468F1E9@DM6PR11MB4596.namprd11.prod.outlook.com>
 <DM6PR11MB45963AAEF4717C359986FBCB8F1E9@DM6PR11MB4596.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <DM6PR11MB45963AAEF4717C359986FBCB8F1E9@DM6PR11MB4596.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-03-29 02:27:31 [+0000], Chen, Angus wrote:
>=20
> Hi there,
Hi,

> The dmesg log from UART port.=C2=A0 After the log showed "the sched: RT t=
hrottling activated", the screen freeze.

any update on what happens after the "-1 to sched_rt_runtime_us" change?

> Best Regards,
> Angus

Sebastian
