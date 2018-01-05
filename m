From: Joshua Kordani <jkordani@lsa2.com>
Subject: Patching kernel versions for which there is no version specific patch
 released?
Date: Fri, 5 Jan 2018 14:22:12 -0500
Message-ID: <5257bd13-632a-757a-0e5c-5310fe8b3835@lsa2.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-sn1nam01on0108.outbound.protection.outlook.com ([104.47.32.108]:14229
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752121AbeAETWS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Jan 2018 14:22:18 -0500
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Greetings,

I am trying to patch a kernel for which there doesn't seem to be a 
specific patch set released.
For example, patch-4.9.61-rt52.patch.xz and patch-4.9.65-rt56.patch.xz 
exist, but nothing in between.  Is it safe to assume that 
patch-4.9.61-rt52.patch.xz is appropriate for all kernel versions from 
4.9.61 to 4.9.64?  Or, since the rt version jumps from 52 to 56, there 
are intermediate versions of the patchset for intermediate versions of 
the kernel that are available only in the git repo?

Looking to make the right call about how to patch what I need instead of 
just compiling and hoping.
Thanks for your help!

Joshua Kordani
