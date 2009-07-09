From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: Problem with hwlat detector in smp_processor_id()
Date: Thu, 09 Jul 2009 16:36:25 +0200
Message-ID: <4A560069.6010602@osadl.org>
References: <4A55D53A.6040108@psysteme.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040703040200030603090805"
Cc: linux-rt-users@vger.kernel.org
To: Wolfgang Steinwender <wolfgang@psysteme.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:49789 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760004AbZGIOhj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Jul 2009 10:37:39 -0400
In-Reply-To: <4A55D53A.6040108@psysteme.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------040703040200030603090805
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/09/2009 01:32 PM, Wolfgang Steinwender wrote:

> [..] When I'm trying the hardware latency test (hwlatdetect.py) I'm
> getting the following messages:
> hwlat_detector: version 1.0.0
> BUG: using smp_processor_id() in preemptible [00000000] code:
> hwlatdetect/3755
> caller is debug_sample_fread+0x138/0x1ea [hwlat_detector] [..]
Does the attached patch help?

	Carsten.

--------------040703040200030603090805
Content-Type: text/x-patch;
 name="hwlat_detector-avoid-smp_processor_id.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hwlat_detector-avoid-smp_processor_id.patch"

Index: linux-2.6.29.5-rt22/drivers/misc/hwlat_detector.c
===================================================================
--- linux-2.6.29.5-rt22.orig/drivers/misc/hwlat_detector.c
+++ linux-2.6.29.5-rt22/drivers/misc/hwlat_detector.c
@@ -191,17 +191,11 @@ static struct sample *buffer_get_sample(
 	if (!sample)
 		return NULL;
 
-	/* ring_buffers are per-cpu but we just want any value */
-	/* so we'll start with this cpu and try others if not */
-	/* Steven is planning to add a generic mechanism */
 	mutex_lock(&ring_buffer_mutex);
-	e = ring_buffer_consume(ring_buffer, smp_processor_id(), NULL);
-	if (!e) {
-		for_each_online_cpu(cpu) {
-			e = ring_buffer_consume(ring_buffer, cpu, NULL);
-			if (e)
-				break;
-		}
+	for_each_online_cpu(cpu) {
+		e = ring_buffer_consume(ring_buffer, cpu, NULL);
+		if (e)
+			break;
 	}
 
 	if (e) {

--------------040703040200030603090805--
