Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795482520;
	b=Qu4teq3iLkkOohiXEsAE6/BSjMWTDujhvy2svN18abFIo1cI6CJd0JJ0VlTvIIxC6y/Z
	 hRRpAeMvYDetXg573LxABPECAkN9cSov+W3TChP9x5hMsYAQfNP7FfwXtjNbPhV9dWsRN
	 DDyZDtRjLqAvMgsCE5K0rae0cShjFBGkUfJpZmLp67GTyHsP9KYl2Om4CynOXXhNG42WT
	 ZObU/KBwP8VsbkQZWNqaDPCAgauBXJ38eivzO7OWrTsCnk2FOBqz5ZPobhy3bUSXlwwA3
	 3WD4W/d9YPwiT+CIpfKnsnIuXLmu5pdqMaC/tQjKDHqjDTnSdUBYObkEaKUbMGYVXTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795482520;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Sender:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fDMMXDjIf8PUs8MI4CX+zhyGsakVj2Azvep1/FrdJVo=;
	b=qIc3xs/O4/DdMuwiJymdd+0P7DXpbx24N0cQ21Gr3u0RV7s6JQfhKdfMGm0gnmqLW62S
	 ScZkFrgLD9GGj16TJOY9EgljozglL5Hlh31fhO164DXWj3s2ZyR235eRJ6/mmbf0Ux4sH
	 29YaNkLQDXtaocaq7Hkxovb5RHK0vwDBSe/0+GnMbqXQiDz0xLIIF0YTutdZYSGAQ1eYd
	 3WMYjey6tXIgaJV5DEft3bBi90CA26E31B4Mr3ecX249GjYeZ2shsn3pNNUYsMpKsxXM8
	 J79YB+Z0MxcpQ8jtQn/Nynm6WZ7bh85qSWTwSOSVTkbKYRWqLDigrLx+ubFZlNwzfzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=redhat.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mQ+3Arpy;
	arc=none smtp.remote-ip=209.85.219.52
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7953606A321
	for <linux-rt-users@vger.kernel.org>; Tue, 24 Nov 2026 01:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7953606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mQ+3Arpy
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-921342fae7eso43756236d6.3
        for <linux-rt-users@vger.kernel.org>; Mon, 23 Nov 2026 17:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795482519; x=1796087319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fDMMXDjIf8PUs8MI4CX+zhyGsakVj2Azvep1/FrdJVo=;
        b=mQ+3ArpyC9eRlq5dYRlkHRvgCSBtWgkbTyZg7mqwjzDoeNHcljSIsuckxxMFzjDsbK
         3LHrWj03dtxMzBHnhpc+2JwV8XHskfKAVMb/WIFg0vtHCY3PhV6EEwubUFou8AjgjixM
         XSJmPW0eimeR6eQeMJZPM/RCEuihpS6/bUTU6sIEPvmgT3jrIrK1Im7SbkiFAoggdk1M
         D0FbA6kPWQmiuCSEyBMOkwEktBe1LE9DBSwV/SpbtcFZODRkk/26WgrAOBzJxYEKp0sh
         iSXfnxlL5XpXzL3ElDb20Jim7HbTpbB4ChdbE60AgEPcYRUwDPs7spAqfKtTZ04/U2zR
         ehDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795482519; x=1796087319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fDMMXDjIf8PUs8MI4CX+zhyGsakVj2Azvep1/FrdJVo=;
        b=sqYcKQjj8L9r5kL3ixRfOO6i1HsTJgwN+wwv71l7gXdTdUR00P0cip/7FDCSyh0wd5
         FgwnxrlKIGmpq2qkHXxqifisRQdWVL9NQ/APw1z2s8Gex6hZU0Z2LOeOa9eEvmsZsq5p
         SFooYCEqzi8mevKN/75srbcrxpi6dgUg42KJ/CJjRjpBrefsMl1OVFbhFpr/P6fEXLJU
         LruXVWY0izBgy3pXbWK+jRUT//bWXPZ1yn7tMQyzYNaMINzG+6AMxH4PNqwPiFqQAEGQ
         A6c5PWQ0tnRJtF7TCnQK9uucgpu0e08I7x56utJt5yua5t4kZtJOg8CSTBdxJsVvJkTj
         Fh5A==
X-Gm-Message-State: APuU4Z9pJdWIf1+hRUr+BPSByGki2QHYLDhtCEv4gp3DT8JZyFbDiicr
	UwoQYQE+jyGrTQA3bZlXcLEIB5hO3+dnhqJXx2d339GnnYoIovimVLAN2ugEjA==
X-Gm-Gg: AZFdTZeUA6KDb6gPfDogDUnSMseICNkMSlEwB4x7yWRCBYMYhEtxcWgiAZZV7kmRXnh
	Jp9KYzgM69xXC08fFuNiAs6I93Ntbol23X1NJqywv1oZg3eUxA6jNY45At5PNo0HUrpYBfeTUQg
	s0rTUSeF9yQWodfp6pePh5IJOMO5+biS+tyFwlNMRuuzhya4dD4jxgLA8I5RtDR+13YRurcsEt2
	lKl/VwKOtvEWekETvbs2e+FhqTVax1ROYsTT7QH/FtaQBJc5uEQvn7fMx5f61+wCGaqWkkBz7nj
	m4vC0feLsHJV4JngqtR1iW0DDsBhZLcV2X+p6KiSH5m9AnNEU0gN/zO4VdZG7nI5nZwriRDlrhB
	G5XKKZifRhm4DCP5tf90xbuTkq2uMcymXTnOxOepDO8Pi/uK1++/Vnvkf8j7M8PgFr0b702Nd7D
	+Eh/OM7E+GAlBSNAAGpa5N+p943IElftTSRl9bQ1e/PzA9LnVa8dhJvbUjSzxZmmYZa5+8hunHk
	18HXZT39zT8zgQeLhyfIcgzfs04ytSQXswGLHDLrx5ue4xw7sCb2z77AuVF1ThsEiPUW5dJG3yH
	Vaf9H/z4LVLb34WoYohsFVZ/OypZIQ9TgXxIEX4mYqH3ijORxhYom7OmG//qg+tFqXaI9rcRpQy
	9pz890kIQhE/UXvXUZc7P+2EtL1j1xVIdqL45
X-Received: by 2002:a05:6214:124e:b0:921:2a6:c6d9 with SMTP id 6a1803df08f44-92134ade7cbmr249484066d6.51.1795482518635;
        Mon, 23 Nov 2026 17:08:38 -0800 (PST)
Received: from jkacur-thinkpadp1gen8.rmtcaon.csb ([70.53.46.49])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349d14d1sm120624806d6.18.2026.11.23.17.08.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 17:08:38 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 6/6] rteval: Pick cpuset integration-test CPUs from cpuset.cpus.effective
Date: Mon, 23 Nov 2026 20:07:48 -0500
Message-ID: <4829be88556091ec8fad0599b716c73a9e273c9b.1795478784.git.jkacur@redhat.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795478784.git.jkacur@redhat.com>
References: <cover.1795478784.git.jkacur@redhat.com>
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Post: <mailto:linux-rt-users@vger.kernel.org>
List-Help: <mailto:linux-rt-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rt-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tests/cpusets/test-cpusets.sh picked its housekeeping/measurement/loads CPU
groups by nproc alone and hardcoded the numbers (0-3 4-7 8-11, ...), so it could
use CPUs that belong to another isolated partition. On a host running intel_lpmd
-- which reserves the low-power CPUs (0-5 here) in its own isolated "lpm"
partition -- those CPUs are not in the root cgroup's cpuset.cpus.effective, so
rteval cannot build an isolated partition from them and six subtests failed under
sudo make test-all.

Choose the CPU groups from cpuset.cpus.effective at runtime instead, emitting
them in the kernel's canonical cpulist form so the cpuset.cpus comparisons still
match. The tests now run on whatever CPUs are actually usable, so they pass
whether or not intel_lpmd (or isolcpus=) is holding some CPUs out of the cgroup
hierarchy.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tests/cpusets/test-cpusets.sh | 65 ++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 16 deletions(-)

diff --git a/tests/cpusets/test-cpusets.sh b/tests/cpusets/test-cpusets.sh
index b5bca42f51b7..33cde278397c 100755
--- a/tests/cpusets/test-cpusets.sh
+++ b/tests/cpusets/test-cpusets.sh
@@ -138,25 +138,58 @@ check_cpuset_has_procs() {
     [ "$count" -gt 0 ]
 }
 
-get_test_cpus() {
-    # Get available CPUs for testing
-    # Returns: "0-3 4-7 8-11" for housekeeping, measurement, loads
-    local online=$(cat /sys/devices/system/cpu/online)
-
-    # Parse online CPUs (e.g., "0-15" or "0-3,8-11")
-    # For simplicity, just use first 12 CPUs if available
-    # Otherwise adapt based on what's available
+_collapse_cpus() {
+    # Collapse sorted integer args into kernel cpuset form,
+    # e.g. "6 7 8 10" -> "6-8,10". Matches how the kernel stores cpuset.cpus,
+    # so string comparisons in check_cpuset_cpus() succeed.
+    local out="" start="" prev="" c
+    for c in "$@"; do
+        if [ -z "$start" ]; then
+            start=$c; prev=$c
+        elif [ "$c" -eq $((prev + 1)) ]; then
+            prev=$c
+        else
+            if [ "$start" = "$prev" ]; then out+="${out:+,}$start"; else out+="${out:+,}$start-$prev"; fi
+            start=$c; prev=$c
+        fi
+    done
+    if [ -n "$start" ]; then
+        if [ "$start" = "$prev" ]; then out+="${out:+,}$start"; else out+="${out:+,}$start-$prev"; fi
+    fi
+    echo "$out"
+}
 
-    local total=$(nproc)
+get_test_cpus() {
+    # Return three disjoint CPU groups "housekeeping measurement loads", chosen
+    # from the CPUs actually usable by cgroup cpusets (cpuset.cpus.effective).
+    # CPUs held in another isolated partition -- e.g. intel_lpmd's "lpm"
+    # partition, or isolcpus= -- are absent from that set and cannot form an
+    # rteval isolated partition, so hardcoding CPU numbers would spuriously fail.
+    local effective
+    effective=$(cat /sys/fs/cgroup/cpuset.cpus.effective 2>/dev/null)
+    [ -n "$effective" ] || effective=$(cat /sys/devices/system/cpu/online)
+
+    # Expand "6-15" / "0-3,8-11" into a sorted CPU list
+    local -a pool=()
+    local part lo hi i old_ifs="$IFS"
+    IFS=','
+    for part in $effective; do
+        if [[ "$part" == *-* ]]; then
+            lo=${part%-*}; hi=${part#*-}
+            for ((i = lo; i <= hi; i++)); do pool+=("$i"); done
+        else
+            pool+=("$part")
+        fi
+    done
+    IFS="$old_ifs"
 
-    if [ "$total" -ge 12 ]; then
-        echo "0-3 4-7 8-11"
-    elif [ "$total" -ge 8 ]; then
-        echo "0-1 2-4 5-7"
-    elif [ "$total" -ge 4 ]; then
-        echo "0 1-2 3"
+    local n=${#pool[@]}
+    if [ "$n" -ge 6 ]; then
+        echo "$(_collapse_cpus "${pool[0]}" "${pool[1]}") $(_collapse_cpus "${pool[2]}" "${pool[3]}") $(_collapse_cpus "${pool[4]}" "${pool[5]}")"
+    elif [ "$n" -ge 4 ]; then
+        echo "$(_collapse_cpus "${pool[0]}") $(_collapse_cpus "${pool[1]}" "${pool[2]}") $(_collapse_cpus "${pool[3]}")"
     else
-        echo "0 0 0"  # Not ideal but at least won't crash
+        echo "${pool[0]:-0} ${pool[0]:-0} ${pool[0]:-0}"
     fi
 }
 
-- 
2.56.1

