From: "Hindman, Gavin" <gavin.hindman@intel.com>
Subject: Intel real-time Linux production kernel
Date: Fri, 2 Jun 2017 18:15:31 +0000
Message-ID: <D5D6254030DBC644B6EE58B333BFBB1E9D673203@ORSMSX101.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Sapra, Rajesh" <rajesh.sapra@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:35751 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750966AbdFBSPd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 2 Jun 2017 14:15:33 -0400
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello everyone,

I wanted to make you all aware that Intel is now maintaining a preempt_rt enabled version of our 4.9LTS production kernel located here: https://github.com/01org/linux-intel-4.9/wiki  Support is fairly new, and doesn't extend much beyond integrating preempt_rt at this point, but this is where we will host real-time related optimized kernel configs for Intel platforms, and feature back-ports, etc. as those emerge.

Thanks,
Gavin Hindman
