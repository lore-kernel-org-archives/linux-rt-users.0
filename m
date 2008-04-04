From: Mauricio =?utf-8?Q?A=2E_Araya_L=F3pez?= <maray@inf.utfsm.cl>
Subject: RT_PREEMPT and Serial Port
Date: Fri, 4 Apr 2008 03:57:53 -0400
Message-ID: <20080404075753.GB28260@alumnos.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from alegre.inf.utfsm.cl ([204.87.169.3]:59865 "EHLO
	alegre.inf.utfsm.cl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755471AbYDDJBB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Apr 2008 05:01:01 -0400
Received: from ritoque.inf.utfsm.cl (ssh2.inf.utfsm.cl [204.87.169.5])
	by alegre.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id m347vrJD003103
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Fri, 4 Apr 2008 03:57:53 -0400
Received: from rodriguez.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by ritoque.inf.utfsm.cl (8.14.2/8.13.8) with ESMTP id m347vrcv028681
	for <linux-rt-users@vger.kernel.org>; Fri, 4 Apr 2008 03:57:53 -0400
Received: (from maray@localhost)
	by rodriguez.inf.utfsm.cl (8.14.2/8.14.2/Submit) id m347vreo028680
	for linux-rt-users@vger.kernel.org; Fri, 4 Apr 2008 03:57:53 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

I've been searching on the web (and in the rt-wiki) for the current
status of the real-time support for devices. For instance
the serial port, CAN Bus, etc.

I am doing some experiments to check if RT_PREEMPT could be an option to
a control system that is using RTAI nowadays.

If not, maybe it is a good thing to develop myself, so if anyone can
comment anything about this, it will be very helpfull to start.

Thanks!

-- 
Mauricio Araya L. 
ACS-UTFSM Team Leader, cel: 0-81564903
Est. Magister en Ciencias de la Informatica UTFSM, Valparaiso, Chile
counter.li.org: #249395, http://www.inf.utfsm.cl/~maray 
