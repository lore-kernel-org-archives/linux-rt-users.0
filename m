From: "Luca Abeni" <lucabe72@gmail.com>
Subject: Does the RT patch contain unrelated hunks?
Date: Wed, 14 Mar 2007 13:21:53 +0100
Message-ID: <185eca360703140521h4ad44ae3wf13506c118bcc8e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:53625 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161195AbXCNMWG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Mar 2007 08:22:06 -0400
Received: by nf-out-0910.google.com with SMTP id o25so189029nfa
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Mar 2007 05:22:04 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi all,

Looking at patch-2.6.21-rc3-rt0, it seems to me that it contains a lot
of unrelated stuff, such as:
--- linux.orig/Documentation/kernel-parameters.txt
+++ linux/Documentation/kernel-parameters.txt
@@ -79,6 +79,7 @@ parameter is applicable:
                        Documentation/scsi/.
        SELINUX SELinux support is enabled.
        SERIAL  Serial support is enabled.
+     SH      SuperH architecture is enabled.
        SMP     The kernel is an SMP kernel.
        SPARC   Sparc architecture is enabled.
        SWSUSP  Software suspend is enabled.
and so on (there are changes to the sparse documentation, etc...).

I am trying to understand the RT patch by looking at the code, so I am
wondering if it's possible to have a version of the patch which
contains only RT-related changes.


                                                       Thanks,
                                                             Luca
