Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48029541E70
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Sep 2026 22:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790116005; cv=none; b=cJVquKqB1PmBz/ndssscZr11ZciY2ULIy2fmJ1i6yA+LUo85PPX6WxjoWZ0g/+56qaPjbDK08rY683a3KfMSZfUDu1TAlmkIqnCq3iLuZljEQc/QlbthAtRhVyaBLGqOh4JTP6r7TKpbqfS8IzDjCt4PDtHm8eOcQLgNGcJBF0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790116005; c=relaxed/simple;
	bh=VjC4Vu/LUSVLRQGSFuG6OAj7L7KXEb4jspnwMQpVjXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kHpRp3KWDXzpIRrLeZrparlsV/yT/lyBsVJ484dN0rISJLlRk8x/rxaHKRMsjp4B9MYeLqGAf8NGFTq2qMK/Jl6+ilyq3AxgSHtuLwV0+GAbgBj7urlp+HMgeVqDX2RUS8esDcP+wZaV2AGK0G3FgQx6j2h5JbYI5yKGTVEnSds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5eCebQI; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5eCebQI"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb766bfd6so3620381cf.1
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Sep 2026 15:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790115987; x=1790720787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z94yGh2HdO9o1yMtKkKIaAndwcY+txetWfLk0WwdRSI=;
        b=Y5eCebQILPOCS6Mi/blH/eUQRts6b3KfY8eqVy2Mz8ifah0ysgvyb/C7/fWYrp7MSd
         zeF3gvSdu+aOSvnG3E30xCYDrEsfc+cEZe10U/+o9llH1HEdQkUHSUpBvEP+zBCy3I5Q
         H3tO++gwhCcaF7dLi0ZDXXM8+MpNTbQI8A0rXTTuAqdoA3vIqA5yJ3etdzhLhc87ji2V
         fQNtipenNSX6RQ6dKjNrxnqawCBdGRItjCOMJVstR6Sn+RtyDsJLyX3+vxHoNqON28L0
         HVpCv64g1r0yMADbqylldB0YzyrYcz3/aiLKqpNF5gS+HTAT304z7ykvWohlP5iQUAcu
         GKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790115987; x=1790720787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z94yGh2HdO9o1yMtKkKIaAndwcY+txetWfLk0WwdRSI=;
        b=fswSq+0HUzHWnAbtx4OqakbGX53ZvXZ0lExkhLTNitPLhjDB8JNWJs9rs+k2wqhtY4
         vz3Ul9C49iMyW8FCK3SYsv+BNN6eZMbiiDvd1snQN7ahZbUxQGMhfGqukjJgK9gW856w
         j35L66X/4278KDI46nWged8/NKr5D3+/qi7dSJTVeMBycN1xpZkL4OWrRaUKgsLaV2nF
         mxlNZJompBfbEjsrunfPXVQvrR9U2PMhrKS9RsquWvn5V2ryHAshoPHtA7Za3eG0FdHy
         ojThLXEoku0Jo2XOGASJSmaHIPMDje/YJbrHK9ZAHKcEoqhbSOI31uvmr3lIZsJtIjxU
         7JEw==
X-Gm-Message-State: AFuF++l/5TRqVoRpNdFS38LeHnv5eyEhGDht5nnabkZbV5JPS7EuUa2Q
	T5WuuYDXfy23X256VawSEWq/2Fhc66OiNZg4TsqlMuMvdIccJSt3idfuQpEoVQ==
X-Gm-Gg: AYBFou0routnnXHmLb5PgQS8SK+IpCeSUOiRbKaEu/rmjXedYd+EKocOaRvJtXY5DTF
	qPNnUo5RvpcUp5pKXCobhTHMHu6KFnTGNbCPIviaMMBsL4LcaySrZ8ZtUk/HuwKsGbCZ6/rxjOR
	kdIjbI5u2BA8XWyyRnahbUR3OrZLFEdxcrFXU+W6oBEel0UNowsKgmAPkwn2kjT9DHS8+MhYZ+1
	4g1dB7cSsZuiCDmJHU983q7kKTEAa4ak/3vvRUJCnHTx1YhnWFdsebxNHJ2sSfFNqEim/xq9gPJ
	3f6teCQNE5QTiMb26Cd0In4JxZBUdaoxOvJ9s6exQEjfSSsc6+x8r/LX46i6kWbdGGrabkHUV6z
	4vUBSB1SpZc1mJL1e/ubkdgjOgKk9hbVoNForNSy04v3pABOUmLAxKhY86aNHHG83u7EgIEtmxp
	0z3ulGtuH/lyqE5wd6uaFG7uzeS+5wEJoGoz7u5IhnlLWlZR58K5iv3LN3dDVjltYBsLZiyTr5H
	hOcT4H1Ym8KallO0uumsGCx8QR/4WPvc6JaqKCUFdK8Er1EKxAtAObdrXp9QTr4Vg==
X-Received: by 2002:a05:622a:5c13:b0:532:d176:5cd7 with SMTP id d75a77b69052e-532eabb4788mr14337961cf.4.1790115987236;
        Tue, 22 Sep 2026 15:26:27 -0700 (PDT)
Received: from Cumhall.home ([70.53.55.174])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9140c4425f3sm7552786d6.34.2026.09.22.15.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 15:26:26 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 0/8] rteval: cpuset placement for measurement and load overlap
Date: Tue, 22 Sep 2026 18:25:44 -0400
Message-ID: <20260922222552.482102-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series improves how rteval places measurement and load workloads when
--cpusets is used, and adds the ability to confine loads to their own cpuset.

Background: rteval --cpusets creates the rteval_measurement cpuset as a
cgroup-v2 isolated partition, which removes its CPUs from the root cgroup's
effective set. Loads run in the root cgroup bound only by CPU affinity
(taskset). In the
default run both cpulists default to all online CPUs (100% overlap), so the
isolated partition starves the taskset-bound loads, kcompile fails, and
rteval exits non-zero. This is why several cpuset tests had been skipped.

The series is in two parts.

Part 1 - overlap validation + --measurement-member (patches 1-6):
Fail loudly by default, and let the user explicitly opt into co-location.
A new --measurement-member flag flips rteval_measurement to a member
partition so loads and measurement may legally share CPUs. When measurement
is isolated and the load/measurement cpulists overlap without
--measurement-member, rteval now exits early with a clear message pointing
at the two ways forward (add --measurement-member, or supply disjoint
cpulists). The check is gated on loads actually running (not --noload /
--onlyload) to avoid firing spuriously. The previously skipped cpuset tests
are re-enabled and updated for the new behavior.

Part 2 - loads in a cpuset (patches 7-8):
A new opt-in --loads-cpuset flag confines load workloads to their own
rteval_loads member cpuset instead of relying only on taskset. It is purely
additive: without the flag, loads use taskset exactly as before. A cpuset is
a hard ceiling the whole kcompile/hackbench descendant subtree inherits and
cannot escape (taskset masks can be widened via sched_setaffinity), and it
lays the groundwork for NUMA memory binding. Placement uses a shared
self-placement-before-exec helper (cpuset_preexec) that the measurement
modules were refactored onto as well. Patch 7 is a standalone bugfix for an
unguarded m[1].lower() over the loads config section that the new boolean
option would otherwise crash on.

Tested on a root machine: the full cpuset shell suite passes, including the
overlapping-member case (--measurement-member together with --loads-cpuset).

John Kacur (8):
  rteval: Add CpuList intersection/difference helpers
  rteval: Don't create measurement cpuset with --onlyload
  rteval: Add --measurement-member and guard against measurement/load
    overlap
  rteval: Re-enable cpuset overlap tests for the new behavior
  rteval: Move --measurement-member into the measurement module option
    group
  rteval: Add tests for overlap-check gating and --measurement-member
    help
  rteval: Guard load module config iteration against non-string values
  rteval: Add --loads-cpuset to confine loads to a member cpuset

 rteval-cmd                               |  51 +-
 rteval/__init__.py                       |  42 +-
 rteval/cpulist_utils.py                  |  26 +
 rteval/cpuset.py                         |  37 ++
 rteval/cpusetmanager.py                  | 125 +++--
 rteval/modules/__init__.py               |  16 +
 rteval/modules/loads/__init__.py         |   6 +-
 rteval/modules/loads/hackbench.py        |   7 +-
 rteval/modules/loads/kcompile.py         |  12 +-
 rteval/modules/loads/stressng.py         |   7 +-
 rteval/modules/measurement/cyclictest.py |  13 +-
 rteval/modules/measurement/timerlat.py   |  13 +-
 tests/cpusets/test-cpusets.sh            | 573 +++++++++++++++++++----
 tests/test_cpulist_class.py              |  60 +++
 tests/test_cpusetmanager.py              | 129 +++++
 15 files changed, 950 insertions(+), 167 deletions(-)

-- 
2.55.0

