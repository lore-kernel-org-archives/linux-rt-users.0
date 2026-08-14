Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4DC3F12EF
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 22:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786745482; cv=none; b=iV4Cr5ytb59MQaJUCqFBzMS0I5mzqA9InKaOzL3k5JebI40NF/AnuOWD2ncCwihZ61FsB2vFKWrXgHnbefyPgST6TujT9TuUmKamMvZrhgjtL80WcH8SqxmQIhrmbvd2e9E1g6H8OuXTvXH2i9Gu+I0ws5/vjgBFYFs3NDUPmLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786745482; c=relaxed/simple;
	bh=SXrktWuDytcsspM7uSj6tE+POp3bCEEX+OfQ+kM54OA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cOiF1STbCVBGLnnYys0Q3o+u4QASvkTX/dM85BrWYBkWdqH4CnTHrFvg2RoCzsy982UeCzS+wzOFl3F/poMStLnkgGginjDIIFNIhuXQc+9m9+MvoslrdFvJCmVJVUmotZFJg00u3vavxLi2+WubgedT+DMRmUWwRqNEqxGqvXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWW8zRy4; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWW8zRy4"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5276d598b96so8503291cf.3
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2026 15:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786745480; x=1787350280; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KaENlSXoC3tN6/9TSVHw/FjxdFF15xw8Rkwb8NfOpz0=;
        b=SWW8zRy4b2zb0Kd240KdLLoW9Z/ziNaJrPVMyEqPdopNmmY6F341dMA4Rk+7qSq+Nb
         2i2ivBcKEE5vVpKVxCrhPlzgOnUmWjGkjR1l+4a+T69DvnH4raF7s0O/3dh6vB06SspJ
         gOAJ+3QHSVPcYhNokRw8/Yv/zcDsmVvl1Ptb8LiCnrZkILyIMIQtZWUwjK175cTcJBLD
         UN1GTGRUvUuw9VA7cRUjDIeoJ926z+GkrmKc29fZuIpp6dnwNr/cSk1HvRr9voy4rdEx
         mx44gDmVlD+YwredZzW9dWDCoJp+YYHLMtTLiyM3OTCrn1zWTzw9iX/I56DEPJyxls45
         IGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786745480; x=1787350280;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KaENlSXoC3tN6/9TSVHw/FjxdFF15xw8Rkwb8NfOpz0=;
        b=Trn96FOzRMYbu3AWwd7K0d3Pxd/KYuhmh2TLVIcFLfZZj1FEMsJJHq7o1HyIVNgxxs
         l3WqvMNtGcnkmRT8fr4wQeiaN/rkb0RNa1TTj+22S2FR3slz4SfFsNhu1EmTM9Ru8tjn
         rNNiv4zWJA0P3EkvUlMKqafD1hWj8Qn2nBZ2h1SmIw1FQAICzz+rccLU1t2fwcaPrAfl
         08nXnJtgooDKQUIQfwhP5cwzj/tHH6ZJjhCvUhthYqY5uws/7aGRcpANxFN52h/aN1eq
         HebbXsI1YyoH+FSlfS3nVDKkLuq1xOouhTTqaM70PSFLYCJ4uHbZqdjy/R3N8qD9ayZ2
         99/w==
X-Gm-Message-State: AOJu0YzEG+6kPg1MzvkIwwUzHwweNdCf5S2XLV5paQxOMc2M4LJwiTW/
	WOeoBnLIujjfK8vCzDZDj/bEexH6SytkyV0okXA0lL4Wnw+svj5zLdVycpc8Tw==
X-Gm-Gg: AR+sD13CHBH1gKU9pogBayuslPaxqvMRBqNG4E9Jv4dhVh+3u6V4m3N4OYGPYGfctay
	5tLbkEAsxBksXVeYZT1/09iue0kkFGrMwUf8BlaRjRJU9H/gUuSQHo7q5tRkY0BYkmsfPlb5TF9
	eXRYGP6TUvsBpwABWkHsyLAfyeIyIHhX37Oh4zGAqF0YQnIjnH9G2zsq9XaxtAHBeUqSZDEyM97
	CHCeSxuX5STnBAgxN21AyfoCMoGDQz6HyTQsHi6hrVz0vaNYbtGoAVqnlOlyG3S/0qUvtrb+0Pa
	5u8kNwQzSglkWrZj2QIkObFubaAKYgTkbwwXYZNiELRBEk7oEOHXDSn6OC0tFr9NiUT4LuvnXkB
	r6pgC1FCijVV7BUhfDyuu3/aeU4PSebIs6g96oiMHw3a0wY6v70xEKwoP9JpLs+v2cJrKfygfEW
	gcE+HrPYxEiuM3a4QgDxtG0dsPErlmb60+CMXH6vZFbY44YbFXl4Yt18KfongkbUXgjhtq6HAhv
	20pmpw5s9L11t3JyTzrFwUYBwmzTq1oue2exfe01c8HrPxaR+xI5Is=
X-Received: by 2002:a05:622a:6816:10b0:52d:94c5:2212 with SMTP id d75a77b69052e-52d94c5234fmr14650511cf.3.1786745479469;
        Fri, 14 Aug 2026 15:11:19 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a935a2bf4sm26105876d6.49.2026.08.14.15.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 15:11:17 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Sana Sharma <sansshar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 21/23] mcp-server: Add demo guide with example queries
Date: Fri, 14 Aug 2026 18:10:20 -0400
Message-ID: <20260814221027.213574-22-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814221027.213574-1-jkacur@redhat.com>
References: <20260814221027.213574-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add DEMO.md to provide users with example queries demonstrating the
MCP server capabilities. The guide includes:

- Prerequisites and test data generation instructions
- Basic operations (listing, parsing, comparing results)
- Query and filtering examples (kernel, date, latency, load)
- Best/worst analysis queries
- Histogram and percentile analysis examples
- Per-CPU statistics and analysis queries
- Load configuration analysis
- Batch analysis and baseline comparison
- Log analysis examples
- Advanced multi-criteria queries
- Tips for effective queries and troubleshooting

Each section includes natural language queries users can ask Claude
Code along with expected results, making it easy for users to explore
the MCP server functionality.

The demo guide complements README.md by focusing on practical usage
examples rather than technical documentation.

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 mcp-server/DEMO.md | 462 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 462 insertions(+)
 create mode 100644 mcp-server/DEMO.md

diff --git a/mcp-server/DEMO.md b/mcp-server/DEMO.md
new file mode 100644
index 000000000000..6bfd1683a7f6
--- /dev/null
+++ b/mcp-server/DEMO.md
@@ -0,0 +1,462 @@
+# rteval MCP Server Demo Guide
+
+This document provides example queries to demonstrate the capabilities of the rteval MCP server when used with Claude Code.
+
+## License
+
+SPDX-License-Identifier: GPL-2.0-or-later
+
+Copyright 2026 John Kacur <jkacur@redhat.com>
+
+This program is free software; you can redistribute it and/or modify
+it under the terms of the GNU General Public License as published by
+the Free Software Foundation; either version 2 of the License, or
+(at your option) any later version.
+
+## Prerequisites
+
+Before running the demo, ensure you have rteval result files available:
+
+```bash
+# Generate some test data if needed
+cd ~/src/rteval
+sudo ./rteval-cmd --duration=5m
+
+# Or use existing results in the rteval directory
+ls -d rteval-*/
+```
+
+## Basic Operations
+
+### Discovering Results
+
+**Query:** "List all rteval results in the current directory"
+
+**Expected:** Shows all rteval-YYYYMMDD-N directories with summary.xml files
+
+---
+
+**Query:** "What rteval results are available?"
+
+**Expected:** Same as above - lists available result directories
+
+---
+
+### Parsing Individual Results
+
+**Query:** "Parse the latest rteval result"
+
+**Expected:** Shows comprehensive summary including:
+- System info (kernel version, architecture, CPU count)
+- Test duration and date
+- Maximum, mean, and median latency
+- Load information
+
+---
+
+**Query:** "Show me the results from rteval-20260714-1"
+
+**Expected:** Detailed metrics for that specific run
+
+---
+
+### Comparing Two Results
+
+**Query:** "Compare rteval-20260714-1 and rteval-20260715-1"
+
+**Expected:** Side-by-side comparison showing:
+- Kernel versions
+- Latency differences (max, mean, median)
+- Load configuration differences
+- Performance improvement/regression percentages
+
+---
+
+## Query and Filtering
+
+### Kernel-Based Filtering
+
+**Query:** "Show me rteval results with kernel 7.0"
+
+**Expected:** Filtered list showing only results running kernel 7.0.x
+
+---
+
+**Query:** "Find rteval results running RT kernels"
+
+**Expected:** Results filtered to show only RT (PREEMPT_RT) kernels
+
+---
+
+### Date Range Filtering
+
+**Query:** "Show me rteval results from June 2026"
+
+**Expected:** Results filtered by date range
+
+---
+
+**Query:** "Find rteval results from the last week"
+
+**Expected:** Recent results within the specified timeframe
+
+---
+
+### Latency Threshold Filtering
+
+**Query:** "Show results with max latency under 5000 microseconds"
+
+**Expected:** Only results where maximum latency is below the threshold
+
+---
+
+**Query:** "Find rteval runs with excellent latency (max < 3000 µs)"
+
+**Expected:** High-performing results meeting the latency criteria
+
+---
+
+### Load Generator Filtering
+
+**Query:** "Show me results that used hackbench"
+
+**Expected:** Results filtered by load generator type
+
+---
+
+**Query:** "Find runs with kcompile load and high load average"
+
+**Expected:** Results using kcompile with specified load characteristics
+
+---
+
+## Best/Worst Analysis
+
+### Finding Best Runs
+
+**Query:** "Find the 5 best rteval runs by maximum latency"
+
+**Expected:** Top 5 runs ranked by lowest maximum latency
+
+---
+
+**Query:** "Which rteval runs had the lowest mean latency?"
+
+**Expected:** Ranked list showing best average performance
+
+---
+
+**Query:** "Show me the best runs by median latency"
+
+**Expected:** Rankings based on median latency metric
+
+---
+
+### Finding Worst Runs
+
+**Query:** "Find the 3 worst rteval runs"
+
+**Expected:** Shows the runs with highest maximum latency
+
+---
+
+**Query:** "Which runs had the poorest performance?"
+
+**Expected:** Identifies problematic runs with high latencies
+
+---
+
+## Histogram and Percentile Analysis
+
+### Extracting Histogram Data
+
+**Query:** "Extract histogram data from rteval-20260714-1"
+
+**Expected:** Shows:
+- Total sample count
+- Latency range (min to max)
+- Top latency buckets with counts and percentages
+- Per-CPU histogram summaries
+
+---
+
+**Query:** "Show me the latency distribution for the latest rteval run"
+
+**Expected:** Histogram showing how latency values are distributed
+
+---
+
+### Percentile Calculations
+
+**Query:** "Calculate P99 and P99.9 percentiles for rteval-20260714-1"
+
+**Expected:** Shows percentile values like:
+- P50 (median)
+- P90
+- P95
+- P99
+- P99.9
+- P99.99
+
+---
+
+**Query:** "What's the P95 latency for the latest run?"
+
+**Expected:** Specific percentile value showing that 95% of samples were below this latency
+
+---
+
+**Query:** "Show me per-CPU percentiles for rteval-20260714-1"
+
+**Expected:** Percentile breakdown for each individual CPU
+
+---
+
+**Query:** "What percentage of samples had latency under 10 microseconds?"
+
+**Expected:** Uses histogram to calculate the cumulative percentage
+
+---
+
+## Per-CPU Analysis
+
+### Basic Per-CPU Statistics
+
+**Query:** "Show me per-CPU statistics for rteval-20260714-1"
+
+**Expected:** Table showing for each CPU:
+- Sample count
+- Min, max, mean, median latency
+- Standard deviation
+
+---
+
+**Query:** "Which CPUs had the worst maximum latency?"
+
+**Expected:** CPUs sorted by maximum latency (worst first)
+
+---
+
+### Identifying Problem CPUs
+
+**Query:** "Show the top 5 CPUs sorted by mean latency"
+
+**Expected:** Table limited to 5 worst CPUs by average latency
+
+---
+
+**Query:** "Highlight CPUs with max latency above 5000 microseconds"
+
+**Expected:** Table with ⚠️ warning symbols next to CPUs exceeding threshold
+
+---
+
+**Query:** "Which CPUs have the most variable latency?"
+
+**Expected:** CPUs sorted by standard deviation (highest first)
+
+---
+
+**Query:** "Which CPU had the worst latency spike?"
+
+**Expected:** Single CPU with the absolute highest maximum latency
+
+---
+
+### Consistency Analysis
+
+**Query:** "Show me the most consistent CPUs"
+
+**Expected:** CPUs sorted by standard deviation (lowest first = most consistent)
+
+---
+
+**Query:** "Are any CPUs consistently slow?"
+
+**Expected:** Analysis of mean latency to find systematically poor performers
+
+---
+
+## Load Analysis
+
+### Load Configuration
+
+**Query:** "What loads were running in rteval-20260714-1?"
+
+**Expected:** Shows:
+- Load generator types (hackbench, kcompile, stressng)
+- Load configuration parameters
+- Load average (1-min, 5-min, 15-min)
+
+---
+
+**Query:** "Show me the load setup for the latest test"
+
+**Expected:** Complete load configuration and metrics
+
+---
+
+**Query:** "What was the load average in this run?"
+
+**Expected:** System load averages during the test
+
+---
+
+## Batch Analysis
+
+### Aggregate Statistics
+
+**Query:** "Analyze all rteval results"
+
+**Expected:** Aggregate statistics showing:
+- Total files analyzed
+- Date range coverage
+- Min/max/average latencies across all runs
+- Min/max/average load averages
+- Individual result summaries
+
+---
+
+**Query:** "What's the average max latency across all runs?"
+
+**Expected:** Single aggregate metric across all results
+
+---
+
+**Query:** "Show me the range of load averages across all runs"
+
+**Expected:** Min and max load averages from all results
+
+---
+
+### Baseline Comparison
+
+**Query:** "Compare all rteval results to rteval-20260605-1/summary.xml"
+
+**Expected:** Shows:
+- Baseline metrics
+- Regressions (results exceeding threshold)
+- Passes (results within threshold)
+- Detailed percentage changes for all comparisons
+
+---
+
+**Query:** "Check for regressions against the baseline with 5% threshold"
+
+**Expected:** Regression detection with custom threshold
+
+---
+
+**Query:** "Which runs regressed compared to rteval-20260605-1?"
+
+**Expected:** List of runs that performed worse than baseline
+
+---
+
+## Log Analysis
+
+### Listing Logs
+
+**Query:** "List logs in rteval-20260714-1"
+
+**Expected:** Shows available log files:
+- timerlat.stdout
+- hackbench.stdout
+- kcompile.stdout
+- dmesg
+- etc.
+
+---
+
+**Query:** "What log files are available for the latest run?"
+
+**Expected:** Complete list of log files in the result directory
+
+---
+
+### Reading Logs
+
+**Query:** "Show me the last 100 lines of the timerlat log"
+
+**Expected:** Tail of the timerlat stdout log
+
+---
+
+**Query:** "Search for 'error' in the timerlat log"
+
+**Expected:** Filtered log showing only lines containing 'error'
+
+---
+
+**Query:** "Show me the beginning of the kcompile log"
+
+**Expected:** First lines (head) of the kcompile log
+
+---
+
+## Advanced Queries
+
+### Multi-Criteria Filtering
+
+**Query:** "Show me RT kernel runs from June 2026 with max latency under 4000 µs"
+
+**Expected:** Results matching all three criteria:
+- RT kernel
+- Date in June 2026
+- Max latency < 4000 µs
+
+---
+
+**Query:** "Find runs with hackbench load and load average between 1000 and 1500"
+
+**Expected:** Results filtered by load type and load average range
+
+---
+
+### Comparative Analysis
+
+**Query:** "How does kernel 7.0 compare to kernel 6.17 in terms of latency?"
+
+**Expected:** Filtering and comparison showing performance differences between kernel versions
+
+---
+
+**Query:** "Show the latency trend over time"
+
+**Expected:** Batch analysis ordered by date showing temporal patterns
+
+---
+
+## Tips for Effective Queries
+
+1. **Be specific with file paths:** Use actual rteval directory names from your system
+2. **Combine criteria:** Most tools support multiple filters for precise analysis
+3. **Use natural language:** The MCP server understands conversational queries
+4. **Ask follow-ups:** Build on previous queries to dive deeper into results
+5. **Verify thresholds:** When filtering by latency, make sure thresholds match your RT requirements
+
+## Expected Data Requirements
+
+For the best demo experience, have:
+- At least 5-10 rteval result directories
+- Results from different kernel versions (preferably mix of RT and non-RT)
+- Results spanning different dates
+- Variety of load generators (hackbench, kcompile, stressng)
+- Some high-latency and some low-latency results for comparison
+
+## Troubleshooting Demo Issues
+
+If queries don't work as expected:
+
+1. **No results found:** Check that rteval result directories exist with summary.xml files
+2. **Empty filters:** Adjust filter criteria to match your actual test data
+3. **Tool not found:** Verify the MCP server is properly installed and enabled in Claude Code
+4. **Permission errors:** Ensure rteval results are readable by your user
+
+## Next Steps
+
+After completing the demo:
+- Review the full tool documentation in README.md
+- Run `make test` to verify the MCP server installation
+- Create baseline results for your specific RT requirements
+- Set up automated regression testing using the baseline comparison tools
-- 
2.55.0

