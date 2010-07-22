From: Andres Cimmarusti <acimmarusti@gmail.com>
Subject: disabling ACPI options video and button kernel 2.6.33.6
Date: Thu, 22 Jul 2010 15:53:03 -0400
Message-ID: <AANLkTinMlWJABsuw-bN7TsueVKTb5duZ1D_GnYoea0lo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41458 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933Ab0GVTxE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Jul 2010 15:53:04 -0400
Received: by fxm14 with SMTP id 14so4587738fxm.19
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Jul 2010 12:53:03 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

I followed this howto, in order to patch pristine 2.6.33.6 kernel sources:
https://rt.wiki.kernel.org/index.php/RT_PREEMPT_HOWTO

At some point it says: "To activate the pm_timer, you can just
activate the ACPI_SUPPORT in menuconfig and deactivate all other sub
modules like "fan", "processor" or "button"."

Unfortunately I couldn't disable "video" nor "button" because they
depend on ACPI, DRM_i915 and AGP_INTEL
Is this ok? or will I lose all the real-time powers?

Thanks

Andres
